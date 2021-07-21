import VioletCore

// cSpell:ignore iterobject

// In CPython:
// Objects -> iterobject.c

// sourcery: pytype = callable_iterator, default, hasGC
public final class PyCallableIterator: PyObject {

  // sourcery: pytypedoc
  internal static let doc: String? = nil

  internal let callable: PyObject
  internal let sentinel: PyObject

  // MARK: - Init

  internal init(callable: PyObject, sentinel: PyObject) {
    self.callable = callable
    self.sentinel = sentinel
    super.init(type: Py.types.callable_iterator)
  }

  override public var description: String {
    return "PyCallableIterator()"
  }

  // MARK: - Class

  // sourcery: pyproperty = __class__
  internal func getClass() -> PyType {
    return self.type
  }

  // MARK: - Attributes

  // sourcery: pymethod = __getattribute__
  internal func getAttribute(name: PyObject) -> PyResult<PyObject> {
    return AttributeHelper.getAttribute(from: self, name: name)
  }

  // MARK: - Iter

  // sourcery: pymethod = __iter__
  internal func iter() -> PyObject {
    return self
  }

  // MARK: - Next

  // sourcery: pymethod = __next__
  internal func next() -> PyResult<PyObject> {
    switch Py.call(callable: self.callable) {
    case let .value(o):
      // If we are equal to 'self.sentinel' then we have to stop
      switch Py.isEqualBool(left: o, right: self.sentinel) {
      case .value(true):
        return .stopIteration()
      case .value(false):
        return .value(o)
      case .error(let e):
        return .error(e)
      }
    case .error(let e),
         .notCallable(let e):
      // This also handles 'StopIteration'
      return .error(e)
    }
  }
}
