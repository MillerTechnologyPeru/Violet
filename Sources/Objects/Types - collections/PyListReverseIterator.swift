import VioletCore

// In CPython:
// Objects -> listobject.c

// sourcery: pytype = list_reverseiterator, default, hasGC
public class PyListReverseIterator: PyObject {

  internal let list: PyList
  internal private(set) var index: Int

  override public var description: String {
    let count = self.list.data.count
    return "PyListReverseIterator(count: \(count), index: \(self.index))"
  }

  // MARK: - Init

  internal init(list: PyList) {
    self.list = list
    self.index = list.elements.count - 1
    super.init(type: Py.types.list_reverseiterator)
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
    if self.index >= 0 {
      let item = self.list.elements[self.index]
      self.index -= 1
      return .value(item)
    }

    self.index = -1
    return .stopIteration()
  }

  // MARK: - Python new

  // sourcery: pymethod = __new__
  internal static func pyNew(type: PyType,
                             args: [PyObject],
                             kwargs: PyDict?) -> PyResult<PyListReverseIterator> {
    return .typeError("cannot create 'list_reverseiterator' instances")
  }
}
