import Core

// In CPython:
// Python -> _warnings.c
// https://docs.python.org/3/library/warnings.html#warnings.warn

private let arguments = ArgumentParser.createOrTrap(
  arguments: ["message", "category", "stacklevel", "source"],
  format: "O|OOO:warn"
)

extension UnderscoreWarnings {

  internal static var warnDoc: String {
    return """
      warn($module, /, message, category=None, stacklevel=1, source=None)
      --

      Issue a warning, or maybe ignore it or raise an exception.
      """
  }

  // sourcery: pymethod = warn, doc = warnDoc
  /// Doc:
  /// https://docs.python.org/3/library/warnings.html#warnings.warn
  ///
  /// static PyObject *
  /// warnings_warn_impl(PyObject *module, PyObject *message, ...)
  internal func warn(args: [PyObject], kwargs: PyDict?) -> PyResult<PyNone> {
    switch arguments.bind(args: args, kwargs: kwargs) {
    case let .value(binding):
      assert(binding.requiredCount == 1, "Invalid required argument count.")
      assert(binding.optionalCount == 3, "Invalid optional argument count.")

      let message = binding.required(at: 0)
      let category = binding.optional(at: 1)
      let stackLevel = binding.optional(at: 2)
      let source = binding.optional(at: 3)
      return self.warn(message: message,
                       category: category,
                       stackLevel: stackLevel,
                       source: source)

    case let .error(e):
      return .error(e)
    }
  }

  public func warn(message: PyObject,
                   category categoryArg: PyObject?,
                   stackLevel stackLevelArg: PyObject? = nil,
                   source: PyObject? = nil) -> PyResult<PyNone> {
    let category: PyType
    switch self.parseCategory(message: message, category: categoryArg) {
    case let .value(c): category = c
    case let .error(e): return .error(e)
    }

    let stackLevel: Int
    switch self.parseStackLevel(level: stackLevelArg) {
    case let .value(l): stackLevel = l
    case let .error(e): return .error(e)
    }

    let frame: PyFrame?
    switch self.getFrame(level: stackLevel) {
    case .value(let f): frame = f
    case .levelTooBig: frame = nil
    case .error(let e): return .error(e)
    }

    let globals = frame?.globals ?? Py.sysModule.__dict__
    let lineNo = Py.newInt(frame?.currentLine ?? 1)

    let registry: WarningRegistry
    switch self.getWarningRegistry(globals: globals) {
    case .value(let d): registry = .value(d)
    case .none: registry = .none
    case .error(let e): return .error(e)
    }

    let module = self.getModuleName(globals: globals)
    let filename = self.getFilename(globals: globals, module: module)

    let warning = self.createWarning(message: message,
                                     category: category,
                                     filename: filename,
                                     lineNo: lineNo,
                                     module: module,
                                     source: source)

    return warning.flatMap { self.warnExplicit(warning: $0, registry: registry) }
  }

  // MARK: - Category

  private func parseCategory(message: PyObject,
                             category: PyObject?) -> PyResult<PyType> {
    if self.isWarningSubtype(type: message.type) {
      return .value(message.type)
    }

    // If 'category' is 'nil' or 'None' -> userWarning
    let userWarning = Py.errorTypes.userWarning
    assert(self.isWarningSubtype(type: userWarning))

    guard let category = category else {
      return .value(userWarning)
    }

    if category.isNone {
      return .value(userWarning)
    }

    let t = category.typeName
    return .typeError("category must be a Warning subclass, not '\(t)'")
  }

  private func isWarningSubtype(type: PyType) -> Bool {
    return type.isSubtype(of: Py.errorTypes.warning)
  }

  // MARK: - Stack level

  private func parseStackLevel(level: PyObject?) -> PyResult<Int> {
    guard let level = level else {
      return .value(1)
    }

    if let pyInt = level as? PyInt {
      if let int = Int(exactly: pyInt.value) {
        return .value(int)
      }

      return .typeError("warn(): stackLevel too big")
    }

    return .typeError("warn(): stackLevel must be an int, not \(level.typeName)")
  }

  // MARK: - Get frame

  private enum GetFrameResult {
    case value(PyFrame)
    case levelTooBig
    case error(PyBaseException)
  }

  private func getFrame(level levelArg: Int) -> GetFrameResult {
    guard let topFrame = Py.delegate.frame else {
      let e = Py.newRuntimeError(msg: "warn(): not able to optain current frame")
      return .error(e)
    }

    var frame = topFrame
    var level = Swift.abs(levelArg)

    let showAllFrames = levelArg <= 0 || self.isInternalFrame(frame: topFrame)
    if showAllFrames {
      while let parent = frame.parent, level > 0 {
        frame = parent
        level -= 1
      }
    } else {
      while let parent = self.getExternalParent(frame: frame), level > 0 {
        frame = parent
        level -= 1
      }
    }

    return level == 0 ? .value(frame) : .levelTooBig
  }

  /// static PyFrameObject *
  /// next_external_frame(PyFrameObject *frame)
  private func getExternalParent(frame: PyFrame) -> PyFrame? {
    var result = frame.parent

    while let f = result, self.isInternalFrame(frame: f) {
      result = f.parent
    }

    return result
  }

  /// static int
  /// is_internal_frame(PyFrameObject *frame)
  private func isInternalFrame(frame: PyFrame) -> Bool {
    let filename = frame.code.filename
    let data = filename.data
    // CPython uses '&&', but this seems kind of weird...
    return data.contains("importlib") || data.contains("_bootstrap")
  }

  // MARK: - Warning registry

  private enum GetWarningRegistryResult {
    case value(PyDict)
    /// Python `None`, not `nil` from `Swift.Optional`.
    case none
    case error(PyBaseException)
  }

  private func getWarningRegistry(globals: PyDict) -> GetWarningRegistryResult {
    if let object = globals.get(id: .__warningregistry__) {
      if object.isNone {
        return .none
      }

      if let dict = object as? PyDict {
        return .value(dict)
      }

      let e = Py.newTypeError(msg: "'registry' must be a dict or None")
      return .error(e)
    }

    let registry = Py.newDict()
    globals.set(id: .__warningregistry__, to: registry)
    return .value(registry)
  }

  // MARK: - Module name

  private func getModuleName(globals: PyDict) -> PyString {
    if let object = globals.get(id: .__name__),
       let string = object as? PyString {
      return string
    }

    return Py.getInterned("<string>")
  }

  // MARK: - File name

  private func getFilename(globals: PyDict, module: PyString) -> PyString {
    if let object = globals.get(id: .__file__),
       let str = object as? PyString {
      return str
    }

    // If we are in '__main__' module, then we have to take filename
    // from arg0.
    if module.compare(with: "__main__") == .equal {
      if let argv = Py.sys.argv as? PyList,
         let first = argv.elements.first as? PyString, !first.data.isEmpty {
        return first
      }
    }

    return Py.getInterned("__main__")
  }
}
