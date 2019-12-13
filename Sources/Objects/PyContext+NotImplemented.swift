import Core

extension PyContext {

  internal func call(_ fn: PyObject, args: [PyObject?]) -> PyResult<PyObject> {
    return .value(self.builtins.none)
  }

  internal func callDir(_ fn: PyObject, args: [PyObject?]) -> DirResult {
    return DirResult()
  }

  public func PyObject_Format(value: PyObject, format: PyObject) -> PyObject {
    return self.builtins.none
  }

  internal func getGlobals() -> [String: PyObject] {
    return [:]
  }
}
