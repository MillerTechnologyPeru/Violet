// In CPython:
// Python -> builtinmodule.c
// https://docs.python.org/3/library/functions.html

extension PyInstance {

  // MARK: - Get

  /// getattr(object, name[, default])
  /// See [this](https://docs.python.org/3/library/functions.html#getattr)
  public func getattr(object: PyObject,
                      name: String,
                      default: PyObject? = nil) -> PyResult<PyObject> {
    let interned = self.interned(name: name)
    return self.getattr(object: object,
                        name: interned,
                        default: `default`)
  }

  /// getattr(object, name[, default])
  /// See [this](https://docs.python.org/3/library/functions.html#getattr)
  public func getattr(object: PyObject,
                      name: IdString,
                      default: PyObject? = nil) -> PyResult<PyObject> {
    return self.getattr(object: object,
                        name: name.value,
                        default: `default`)
  }

  /// getattr(object, name[, default])
  /// See [this](https://docs.python.org/3/library/functions.html#getattr)
  ///
  /// static PyObject *
  /// builtin_getattr(PyObject *self, PyObject *const *args, Py_ssize_t nargs)
  /// static PyObject *
  /// slot_tp_getattr_hook(PyObject *self, PyObject *name)
  /// int
  /// _PyObject_LookupAttr(PyObject *v, PyObject *name, PyObject **result)
  public func getattr(object: PyObject,
                      name: PyObject,
                      default: PyObject? = nil) -> PyResult<PyObject> {
    guard let name = name as? PyString else {
      return .typeError("getattr(): attribute name must be string")
    }

    // Fast protocol-based path
    if let result = Fast.__getattribute__(object, name: name) {
      return self.defaultIfAttributeError(result: result, default: `default`)
    }

    // Calling '__getattribute__' method could ask for '__getattribute__' attribute.
    // Which would try to call '__getattribute__' to get '__getattribute__'.
    // Which would... (you probably know where this is going...)
    // Anyway... we have to break the cycle.
    // Trust me it is not a hack, it is... yeah it is a hack.
    if name.value == "__getattribute__" {
      let result = AttributeHelper.getAttribute(from: object, name: name)
      return self.defaultIfAttributeError(result: result, default: `default`)
    }

    // Slow python path
    // attribute names tend to be reused, so we will intern them
    switch self.callMethod(object: object, selector: .__getattribute__, arg: name) {
    case .value(let o):
      return .value(o)
    case .missingMethod:
      let result = AttributeHelper.getAttribute(from: object, name: name)
      return self.defaultIfAttributeError(result: result, default: `default`)
    case .notCallable(let e):
      return .error(e)
    case .error(let e):
      return self.defaultIfAttributeError(error: e, default: `default`)
    }
  }

  private func defaultIfAttributeError(result: PyResult<PyObject>,
                                       default: PyObject?) -> PyResult<PyObject> {
    guard case let PyResult.error(e) = result else {
      return result
    }

    return self.defaultIfAttributeError(error: e, default: `default`)
  }

  private func defaultIfAttributeError(error: PyBaseException,
                                       default: PyObject?) -> PyResult<PyObject> {
    // We are only interested in AttributeError
    guard error.isAttributeError else {
      return .error(error)
    }

    // It is AttributeError. If we have `default` then return it.
    if let def = `default` {
      return .value(def)
    }

    return .error(error)
  }

  // MARK: - Has

  /// hasattr(object, name)
  /// See [this](https://docs.python.org/3/library/functions.html#hasattr)
  public func hasattr(object: PyObject, name: String) -> PyResult<Bool> {
    let interned = self.interned(name: name)
    return self.hasattr(object: object, name: interned)
  }

  /// hasattr(object, name)
  /// See [this](https://docs.python.org/3/library/functions.html#hasattr)
  public func hasattr(object: PyObject, name: IdString) -> PyResult<Bool> {
    return self.hasattr(object: object, name: name.value)
  }

  /// hasattr(object, name)
  /// See [this](https://docs.python.org/3/library/functions.html#hasattr)
  public func hasattr(object: PyObject, name: PyObject) -> PyResult<Bool> {
    guard let name = name as? PyString else {
      return .typeError("hasattr(): attribute name must be string")
    }

    switch self.getattr(object: object, name: name, default: nil) {
    case .value:
      return .value(true)

    case .error(let e):
      if e.isAttributeError {
        return .value(false)
      }

      return .error(e)
    }
  }

  // MARK: - Set

  /// setattr(object, name, value)
  /// See [this](https://docs.python.org/3/library/functions.html#setattr)
  public func setattr(object: PyObject,
                      name: String,
                      value: PyObject) -> PyResult<PyNone> {
    let interned = self.interned(name: name)
    return self.setattr(object: object, name: interned, value: value)
  }

  /// setattr(object, name, value)
  /// See [this](https://docs.python.org/3/library/functions.html#setattr)
  public func setattr(object: PyObject,
                      name: IdString,
                      value: PyObject) -> PyResult<PyNone> {
    return self.setattr(object: object, name: name.value, value: value)
  }

  /// setattr(object, name, value)
  /// See [this](https://docs.python.org/3/library/functions.html#setattr)
  public func setattr(object: PyObject,
                      name: PyObject,
                      value: PyObject) -> PyResult<PyNone> {
    guard let name = name as? PyString else {
      return .typeError("setattr(): attribute name must be string")
    }

    if let result = Fast.__setattr__(object, name: name, value: value) {
      return result
    }

    switch self.callMethod(object: object, selector: .__setattr__, args: [name, value]) {
    case .value:
      return .value(self.none)
    case .missingMethod:
      let typeName = object.typeName
      let operation = value is PyNone ? "del" : "assign to"
      let details = "(\(operation) \(name.reprRaw()))"

      switch self.hasattr(object: object, name: name) {
      case .value(true):
        return .typeError("'\(typeName)' object has only read-only attributes \(details)")
      case .value(false):
        return .typeError("'\(typeName)' object has no attributes \(details)")
      case let .error(e):
        return .error(e)
      }
    case .error(let e), .notCallable(let e):
      return .error(e)
    }
  }

  // MARK: - Delete

  /// delattr(object, name)
  /// See [this](https://docs.python.org/3/library/functions.html#delattr)
  public func delattr(object: PyObject, name: String) -> PyResult<PyNone> {
    let interned = self.interned(name: name)
    return self.delattr(object: object, name: interned)
  }

  /// delattr(object, name)
  /// See [this](https://docs.python.org/3/library/functions.html#delattr)
  public func delattr(object: PyObject, name: IdString) -> PyResult<PyNone> {
    return self.delattr(object: object, name: name.value)
  }

  /// delattr(object, name)
  /// See [this](https://docs.python.org/3/library/functions.html#delattr)
  public func delattr(object: PyObject, name: PyObject) -> PyResult<PyNone> {
    guard let name = name as? PyString else {
      return .typeError("delattr(): attribute name must be string")
    }

    return self.setattr(object: object, name: name, value: self.none)
  }

  // MARK: - Lookup

  public enum LookupResult {
    case value(PyObject)
    case notFound
    case error(PyBaseException)
  }

  /// Look for a name through the MRO.
  ///
  /// _PyObject_LookupSpecial(PyObject *self, _Py_Identifier *attrid)
  public func getFromType(object: PyObject, name: IdString) -> LookupResult {
    let type = object.type
    guard let attribute = type.lookup(name: name) else {
      return .notFound
    }

    if let descr = GetDescriptor(object: object, attribute: attribute) {
      switch descr.call() {
      case let .value(o): return .value(o)
      case let .error(e): return .error(e)
      }
    }

    return .value(attribute)
  }

  // MARK: - Helpers

  /// We will intern attribute names, because they tend to be repeated a lot.
  private func interned(name: String) -> PyString {
    return self.intern(name)
  }
}
