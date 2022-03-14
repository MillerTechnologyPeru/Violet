import VioletCore

// In CPython:
// Objects -> exceptions.c
// Lib->test->exception_hierarchy.txt <-- this is amazing
// https://docs.python.org/3.7/c-api/exceptions.html
// https://www.python.org/dev/peps/pep-0415/#proposal

// sourcery: pyerrortype = SystemExit, pybase = BaseException, isDefault, isBaseType, hasGC
// sourcery: isBaseExceptionSubclass, instancesHave__dict__
public struct PySystemExit: PyErrorMixin {

  // sourcery: pytypedoc
  internal static let systemExitDoc = "Request to exit from the interpreter."

  // sourcery: includeInLayout
  internal var code: PyObject? {
    get { self.codePtr.pointee }
    nonmutating set { self.codePtr.pointee = newValue }
  }

  public let ptr: RawPtr

  public init(ptr: RawPtr) {
    self.ptr = ptr
  }

  // swiftlint:disable:next function_parameter_count
  internal func initialize(_ py: Py,
                           type: PyType,
                           code: PyObject?,
                           traceback: PyTraceback? = nil,
                           cause: PyBaseException? = nil,
                           context: PyBaseException? = nil,
                           suppressContext: Bool = PyErrorHeader.defaultSuppressContext) {
    var argsElements = [PyObject]()
    if let code = code {
      argsElements.append(code)
    }

    let args = py.newTuple(elements: argsElements)
    self.errorHeader.initialize(py,
                                type: type,
                                args: args,
                                traceback: traceback,
                                cause: cause,
                                context: context,
                                suppressContext: suppressContext)

    self.codePtr.initialize(to: code)
  }

  // swiftlint:disable:next function_parameter_count
  internal func initialize(_ py: Py,
                           type: PyType,
                           args: PyTuple,
                           traceback: PyTraceback? = nil,
                           cause: PyBaseException? = nil,
                           context: PyBaseException? = nil,
                           suppressContext: Bool = PyErrorHeader.defaultSuppressContext) {
    self.errorHeader.initialize(py,
                                type: type,
                                args: args,
                                traceback: traceback,
                                cause: cause,
                                context: context,
                                suppressContext: suppressContext)

    let code: PyObject?
    switch Self.getInitCode(args: args.elements) {
    case .none: code = nil
    case .object(let object): code = object
    case .tuple(let elements): code = py.newTuple(elements: elements).asObject
    }

    self.codePtr.initialize(to: code)
  }

  private enum InitCode {
    case none
    case object(PyObject)
    case tuple([PyObject])
  }

  private static func getInitCode(args: [PyObject]) -> InitCode {
    switch args.count {
    case 0:
      return .none
    case 1:
      let object = args[0]
      return .object(object)
    default:
      return .tuple(args)
    }
  }

  // Nothing to do here.
  internal func beforeDeinitialize() { }

  internal static func createDebugString(ptr: RawPtr) -> String {
    let zelf = PySystemExit(ptr: ptr)
    return "PySystemExit(type: \(zelf.typeName), flags: \(zelf.flags))"
  }

  // MARK: - Class

  // sourcery: pyproperty = __class__
  internal static func __class__(_ py: Py, zelf: PyObject) -> PyType {
    return zelf.type
  }

  // MARK: - Dict

  // sourcery: pyproperty = __dict__
  internal static func __dict__(_ py: Py, zelf: PyObject) -> PyResult<PyObject> {
    guard let zelf = Self.downcast(py, zelf) else {
      return Self.invalidZelfArgument(py, zelf, "__dict__")
    }

    return PyResult(zelf.__dict__)
  }

  // MARK: - Code

  // sourcery: pyproperty = code, setter
  internal static func code(_ py: Py, zelf: PyObject) -> PyResult<PyObject> {
    guard let zelf = Self.downcast(py, zelf) else {
      return Self.invalidZelfArgument(py, zelf, "code")
    }

    return PyResult(py, zelf.code)
  }

  internal static func code(_ py: Py,
                            zelf: PyObject,
                            value: PyObject?) -> PyResult<PyObject> {
    guard let zelf = Self.downcast(py, zelf) else {
      return Self.invalidZelfArgument(py, zelf, "code")
    }

    zelf.code = value
    return .none(py)
  }

  // MARK: - Python new

  // sourcery: pystaticmethod = __new__
  internal static func __new__(_ py: Py,
                               type: PyType,
                               args: [PyObject],
                               kwargs: PyDict?) -> PyResult<PyObject> {
    let result = py.memory.newSystemExit(
      py,
      type: type,
      code: nil,
      traceback: nil,
      cause: nil,
      context: nil,
      suppressContext: PyErrorHeader.defaultSuppressContext
    )

    // 'code' will be filled later in '__init__', but 'args' have to be filled here.
    let argsTuple = py.newTuple(elements: args)
    result.args = argsTuple
    return PyResult(result)
  }

  // MARK: - Python init

  // sourcery: pymethod = __init__
  internal static func __init__(_ py: Py,
                                zelf: PyObject,
                                args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyObject> {
    guard let zelf = Self.downcast(py, zelf) else {
      return Self.invalidZelfArgument(py, zelf, "__init__")
    }

    switch Self.getInitCode(args: args) {
    case .none:
      zelf.code = nil
    case .object(let code):
      zelf.code = code
    case .tuple(let elements):
      let code = py.newTuple(elements: elements)
      zelf.code = code.asObject
    }

    let zelfAsObject = zelf.asObject
    return PyBaseException.__init__(py, zelf: zelfAsObject, args: args, kwargs: kwargs)
  }
}
