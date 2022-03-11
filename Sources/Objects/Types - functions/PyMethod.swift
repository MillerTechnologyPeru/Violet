import VioletBytecode

// cSpell:ignore classobject getattro

// In CPython:
// Objects -> classobject.c

// sourcery: pytype = method, isDefault, hasGC
/// Function bound to an object.
public struct PyMethod: PyObjectMixin {

  // sourcery: pytypedoc
  internal static let doc = """
    method(function, instance)

    Create a bound instance method object.
    """

  // sourcery: includeInLayout
  /// The callable object implementing the method
  internal var function: PyFunction { self.functionPtr.pointee }

  // sourcery: includeInLayout
  /// The instance it is bound to
  internal var object: PyObject { self.objectPtr.pointee }

  public let ptr: RawPtr

  public init(ptr: RawPtr) {
    self.ptr = ptr
  }

  internal func initialize(_ py: Py,
                           type: PyType,
                           function: PyFunction,
                           object: PyObject) {
    self.header.initialize(py, type: type)
    self.functionPtr.initialize(to: function)
    self.objectPtr.initialize(to: object)
  }

  // Nothing to do here.
  internal func beforeDeinitialize() { }

  internal static func createDebugString(ptr: RawPtr) -> String {
    let zelf = PyMethod(ptr: ptr)
    return "PyMethod(type: \(zelf.typeName), flags: \(zelf.flags))"
  }

  // MARK: - Equatable, comparable

  // sourcery: pymethod = __eq__
  internal static func abstract__eq__(_ py: Py,
                                      zelf: PyObject,
                                      other: PyObject) -> CompareResult {
    guard let zelf = Self.downcast(py, zelf) else {
      return .invalidSelfArgument(zelf, Self.pythonTypeName, .__eq__)
    }

    return Self.isEqual(py, zelf: zelf, other: other)
  }

  // sourcery: pymethod = __ne__
  internal static func abstract__ne__(_ py: Py,
                                      zelf: PyObject,
                                      other: PyObject) -> CompareResult {
    guard let zelf = Self.downcast(py, zelf) else {
      return .invalidSelfArgument(zelf, Self.pythonTypeName, .__ne__)
    }

    let isEqual = Self.isEqual(py, zelf: zelf, other: other)
    return isEqual.not
  }

  private static func isEqual(_ py: Py,
                              zelf: PyMethod,
                              other: PyObject) -> CompareResult {
    guard let other = py.cast.asMethod(other) else {
      return .notImplemented
    }

    let zelfFn = zelf.function.asObject
    let otherFn = other.function.asObject
    switch py.isEqualBool(left: zelfFn, right: otherFn) {
    case .value(true): break // compare self
    case .value(false): return .value(false)
    case .error(let e): return .error(e)
    }

    switch py.isEqualBool(left: zelf.object, right: other.object) {
    case .value(let b): return .value(b)
    case .error(let e): return .error(e)
    }
  }

  internal static func __lt__(_ py: Py, zelf: PyObject, other: PyObject) -> CompareResult {
    if Self.downcast(py, zelf) == nil {
      return .invalidSelfArgument(zelf, Self.pythonTypeName, .__lt__)
    }

    return .notImplemented
  }

  internal static func __le__(_ py: Py, zelf: PyObject, other: PyObject) -> CompareResult {
    if Self.downcast(py, zelf) == nil {
      return .invalidSelfArgument(zelf, Self.pythonTypeName, .__le__)
    }

    return .notImplemented
  }

  internal static func __gt__(_ py: Py, zelf: PyObject, other: PyObject) -> CompareResult {
    if Self.downcast(py, zelf) == nil {
      return .invalidSelfArgument(zelf, Self.pythonTypeName, .__gt__)
    }

    return .notImplemented
  }

  internal static func __ge__(_ py: Py, zelf: PyObject, other: PyObject) -> CompareResult {
    if Self.downcast(py, zelf) == nil {
      return .invalidSelfArgument(zelf, Self.pythonTypeName, .__ge__)
    }

    return .notImplemented
  }

  // MARK: - String

  // sourcery: pymethod = __repr__
  internal static func __repr__(_ py: Py, zelf: PyObject) -> PyResult<PyObject> {
    guard let zelf = Self.downcast(py, zelf) else {
      return Self.invalidZelfArgument(py, zelf, "__repr__")
    }

    let objectRepr: String
    switch py.reprString(object: zelf.object) {
    case let .value(s): objectRepr = s
    case let .error(e): return .error(e)
    }

    let functionName = zelf.function.qualname.value
    let result = "<bound method \(functionName) of \(objectRepr)>"
    return PyResult(py, result)
  }

  // MARK: - Class

  // sourcery: pyproperty = __class__
  internal static func __class__(_ py: Py, zelf: PyObject) -> PyType {
    return zelf.type
  }

  // MARK: - Hashable

  // sourcery: pymethod = __hash__
  internal static func __hash__(_ py: Py, zelf: PyObject) -> HashResult {
    guard let zelf = Self.downcast(py, zelf) else {
      return .invalidSelfArgument(zelf, Self.pythonTypeName)
    }

    let objectHash: PyHash
    switch py.hash(object: zelf.object) {
    case let .value(h): objectHash = h
    case let .error(e): return .error(e)
    }

    let fnHash: PyHash
    let fnObject = zelf.function.asObject
    switch py.hash(object: fnObject) {
    case let .value(h): fnHash = h
    case let .error(e): return .error(e)
    }

    let result = objectHash ^ fnHash
    return .value(result)
  }

  // MARK: - Attributes

  // sourcery: pymethod = __getattribute__
  /// static PyObject *
  /// method_getattro(PyObject *obj, PyObject *name)
  internal static func __getattribute__(_ py: Py,
                                        zelf: PyObject,
                                        name: PyObject) -> PyResult<PyObject> {
    guard let zelf = Self.downcast(py, zelf) else {
      return Self.invalidZelfArgument(py, zelf, "__getattribute__")
    }

    switch AttributeHelper.extractName(py, name: name) {
    case let .value(n):
      return Self.getAttribute(py, zelf: zelf, name: n)
    case let .error(e):
      return .error(e)
    }
  }

  /// static PyObject *
  /// method_getattro(PyObject *obj, PyObject *name)
  internal static func getAttribute(_ py: Py,
                                    zelf: PyMethod,
                                    name: PyString) -> PyResult<PyObject> {
    switch zelf.type.mroLookup(py, name: name) {
    case .value(let lookup):
      let zelfObject = zelf.asObject
      if let descriptor = GetDescriptor(py, object: zelfObject, attribute: lookup.object) {
        return descriptor.call()
      } else {
        return PyResult(lookup.object)
      }

    case .notFound:
      // Take 'attribute' from function!
      // Easy to miss.
      // (In fact we totally did miss it when implementing this type)
      let function = zelf.function.asObject
      return AttributeHelper.getAttribute(py, object: function, name: name)

    case .error(let e):
      return .error(e)
    }
  }

  // sourcery: pymethod = __setattr__
  internal static func __setattr__(_ py: Py,
                                   zelf: PyObject,
                                   name: PyObject,
                                   value: PyObject?) -> PyResult<PyObject> {
    guard let zelf = Self.downcast(py, zelf) else {
      return Self.invalidZelfArgument(py, zelf, "__setattr__")
    }

    return AttributeHelper.setAttribute(py, object: zelf.asObject, name: name, value: value)
  }

  // sourcery: pymethod = __delattr__
  internal static func __delattr__(_ py: Py,
                                   zelf: PyObject,
                                   name: PyObject) -> PyResult<PyObject> {
    guard let zelf = Self.downcast(py, zelf) else {
      return Self.invalidZelfArgument(py, zelf, "__delattr__")
    }

    return AttributeHelper.delAttribute(py, object: zelf.asObject, name: name)
  }

  // MARK: - Getters

  // sourcery: pymethod = __func__
  internal static func __func__(_ py: Py, zelf: PyObject) -> PyResult<PyObject> {
    guard let zelf = Self.downcast(py, zelf) else {
      return Self.invalidZelfArgument(py, zelf, "__func__")
    }

    return PyResult(zelf.function)
  }

  // sourcery: pymethod = __self__
  internal static func __self__(_ py: Py, zelf: PyObject) -> PyResult<PyObject> {
    guard let zelf = Self.downcast(py, zelf) else {
      return Self.invalidZelfArgument(py, zelf, "__self__")
    }

    return PyResult(zelf.object)
  }

  // sourcery: pyproperty = __doc__
  internal static func __doc__(_ py: Py, zelf: PyObject) -> PyResult<PyObject> {
    guard let zelf = Self.downcast(py, zelf) else {
      return Self.invalidZelfArgument(py, zelf, "__doc__")
    }

    let result = zelf.function.doc
    return PyResult(py, result)
  }

  // MARK: - Get

  // sourcery: pymethod = __get__
  internal static func __get__(_ py: Py,
                               zelf: PyObject,
                               object: PyObject,
                               type: PyObject) -> PyResult<PyObject> {
    guard let zelf = Self.downcast(py, zelf) else {
      return Self.invalidZelfArgument(py, zelf, "__get__")
    }

    if py.isDescriptorStaticMarker(object) {
      return PyResult(zelf)
    }

    let result = py.newMethod(fn: zelf.function, object: object)
    return PyResult(result)
  }

  // MARK: - Call

  // sourcery: pymethod = __call__
  internal static func __call__(_ py: Py,
                                zelf: PyObject,
                                args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyObject> {
    guard let zelf = Self.downcast(py, zelf) else {
      return Self.invalidZelfArgument(py, zelf, "__call__")
    }

    let realArgs = [zelf.object] + args
    let function = zelf.function.asObject
    return PyFunction.__call__(py,
                               zelf: function,
                               args: realArgs,
                               kwargs: kwargs)
  }
}
