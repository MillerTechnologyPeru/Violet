// In CPython:
// Objects -> namespaceobject.c

// sourcery: pytype = types.SimpleNamespace
public final class PyNamespace: PyObject {

  internal static let doc: String = """
    A simple attribute-based namespace.

    SimpleNamespace(**kwargs)
    """

  internal let _attributes = Attributes()

  internal init(_ context: PyContext, name: PyObject, doc: PyObject? = nil) {
    super.init(type: context.builtins.types.simpleNamespace)
  }

  // MARK: - Equatable

  // sourcery: pymethod = __eq__
  internal func isEqual(_ other: PyObject) -> PyResultOrNot<Bool> {
    guard let other = other as? PyNamespace else {
      return .notImplemented
    }

    switch self._attributes.isEqual(to: other._attributes) {
    case let .value(b): return .value(b)
    case let .error(e): return .error(e)
    }
  }

  // sourcery: pymethod = __ne__
  internal func isNotEqual(_ other: PyObject) -> PyResultOrNot<Bool> {
    return NotEqualHelper.fromIsEqual(self.isEqual(other))
  }

  // MARK: - Comparable

  // sourcery: pymethod = __lt__
  internal func isLess(_ other: PyObject) -> PyResultOrNot<Bool> {
    return .notImplemented
  }

  // sourcery: pymethod = __le__
  internal func isLessEqual(_ other: PyObject) -> PyResultOrNot<Bool> {
    return .notImplemented
  }

  // sourcery: pymethod = __gt__
  internal func isGreater(_ other: PyObject) -> PyResultOrNot<Bool> {
    return .notImplemented
  }

  // sourcery: pymethod = __ge__
  internal func isGreaterEqual(_ other: PyObject) -> PyResultOrNot<Bool> {
    return .notImplemented
  }

  // MARK: - Dict

  // sourcery: pyproperty = __dict__
  internal func dict() -> Attributes {
    return self._attributes
  }

  // MARK: - String

  // sourcery: pymethod = __repr__
  internal func repr() -> PyResult<String> {
    // TODO: name = (Py_TYPE(ns) == &_PyNamespace_Type) ? "namespace" : ns->ob_type->tp_name;
    let name = "namespace"

    if self.hasReprLock {
      return .value(name + "(...)")
    }

    return self.withReprLock {
      var list = [String]()
      for entry in self._attributes.entries {
        switch self.builtins.repr(entry.value) {
        case let .value(o): list.append("\(entry.key)=\(o)")
        case let .error(e): return .error(e)
        }
      }

      let listJoined = list.joined(separator: ", ")
      return .value("\(name)(\(listJoined))")
    }
  }

  // MARK: - Attributes

  // sourcery: pymethod = __getattribute__
  internal func getAttribute(name: PyObject) -> PyResult<PyObject> {
    return AttributeHelper.getAttribute(from: self, name: name)
  }

  // sourcery: pymethod = __setattr__
  internal func setAttribute(name: PyObject, value: PyObject?) -> PyResult<PyNone> {
    return AttributeHelper.setAttribute(on: self, name: name, to: value)
  }

  // sourcery: pymethod = __delattr__
  internal func delAttribute(name: PyObject) -> PyResult<PyNone> {
    return AttributeHelper.delAttribute(on: self, name: name)
  }
}
