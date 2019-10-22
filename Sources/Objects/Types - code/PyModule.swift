// In CPython:
// Objects -> moduleobject.c

// sourcery: pytype = module
public class PyModule: PyObject {

  public static let doc: String = """
    module(name, doc=None)
    --
    Create a module object.
    The name must be a string; the optional doc argument can have any type.
    """

  internal var _attributes = Attributes()

  private var name: String {
    guard let obj = self._attributes["__name__"] else {
      return "module"
    }

    guard let str = obj as? PyString else {
      return self.context._repr(value: obj)
    }

    return str.value
  }

  public convenience init(_ context: PyContext, name: String, doc: String? = nil) {
    let n = context._string(name)
    let d = doc.map(context._string)
    self.init(context, name: n, doc: d)
  }

  public init(_ context: PyContext, name: PyObject, doc: PyObject? = nil) {
    super.init(type: context.types.module)
    self._attributes["__name__"] = name
    self._attributes["__doc__"] = doc
    self._attributes["__package__"] = context._none
    self._attributes["__loader__"] = context._none
    self._attributes["__spec__"] = context._none
  }

  // MARK: - Dict

  // sourcery: pyproperty = __dict__
  public func dict() -> Attributes {
    return self._attributes
  }

  // MARK: - String

  // sourcery: pymethod = __repr__
  public func repr() -> String {
    return "'\(self.name)'"
  }

  // MARK: - Attributes

  // sourcery: pymethod = __getattribute__
  public func getAttribute(name: String) -> PyResult<PyObject> {
    if let value = self._attributes.get(key: name) {
      return .value(value)
    }

    if case let .value(v) = self.type.getAttribute(name: name) {
      return .value(v)
    }

    return .error(
      .attributeError("module '\(self.name)' has no attribute '\(name)'")
    )
  }

  // sourcery: pymethod = __setattr__
  public func setAttribute(name: String, value: PyObject) {
    self._attributes.set(key: name, value: value)
  }

  // sourcery: pymethod = __delattr__
  public func delAttribute(name: String) -> PyResult<PyObject> {
    switch self._attributes.del(key: name) {
    case let .some(v):
      return .value(v)
    case .none:
      return .error(
        .attributeError("module '\(self.name)' has no attribute '\(name)'")
      )
    }
  }

  // MARK: - Dir

  // sourcery: pymethod = __dir__
  // sourcery: pydoc = "__dir__() -> list\nspecialized dir() implementation"
  public func dir() -> [String] {
    return self._attributes.keys
  }
}
