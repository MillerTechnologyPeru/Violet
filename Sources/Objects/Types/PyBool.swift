import Core

// In CPython:
// Objects -> boolobject.c
// https://docs.python.org/3.7/c-api/bool.html

/// Booleans in Python are implemented as a subclass of integers.
/// There are only two booleans, Py_False and Py_True.
/// As such, the normal creation and deletion functions don’t apply to booleans.
internal final class PyBool: PyInt {
  fileprivate init(type: PyBoolType, value: BigInt) {
    super.init(type: type, value: value)
  }
}

/// Booleans in Python are implemented as a subclass of integers.
/// There are only two booleans, Py_False and Py_True.
/// As such, the normal creation and deletion functions don’t apply to booleans.
internal final class PyBoolType: PyIntType {

  override internal var name: String { return "bool" }
  override internal var base: PyType? { return self.context.types.int }
  override internal var doc:  String { return """
bool(x) -> bool

Returns True when the argument x is true, False otherwise.
The builtins True and False are the only two instances of the class bool.
The class bool is a subclass of the class int, and cannot be subclassed
"""}

  // MARK: - Ctors

  internal lazy var `true`  = PyBool(type: self, value: BigInt(1))
  internal lazy var `false` = PyBool(type: self, value: BigInt(0))

  internal func new(_ value: Bool) -> PyBool {
    return value ? self.true : self.false
  }

  override internal func new(_ value: BigInt) -> PyBool {
    return self.new(self.isTrue(value))
  }

  // MARK: - String

  override internal func repr(value: PyObject) throws -> String {
    let value = try self.extractInt(value)
    return self.isTrue(value) ? "True" : "False"
  }

  override internal func str(value: PyObject) throws -> String {
    return try self.repr(value: value)
  }

  // MARK: - Binary

  override internal func and(left: PyObject, right: PyObject) throws -> PyObject {
    guard let l = self.extractIntOrNil(left),
          let r = self.extractIntOrNil(right) else {
        return try super.and(left: left, right: right)
    }
    return self.new(self.isTrue(l) && self.isTrue(r))
  }

  override internal func or(left: PyObject, right: PyObject) throws -> PyObject {
    guard let l = self.extractIntOrNil(left),
          let r = self.extractIntOrNil(right) else {
        return try super.and(left: left, right: right)
    }
    return self.new(self.isTrue(l) || self.isTrue(r))
  }

  override internal func xor(left: PyObject, right: PyObject) throws -> PyObject {
    guard let l = self.extractIntOrNil(left),
          let r = self.extractIntOrNil(right) else {
        return try super.and(left: left, right: right)
    }
    return self.new(self.isTrue(l) != self.isTrue(r))
  }

  // MARK: - Helpers

  private func isTrue(_ value: BigInt) -> Bool {
    return value != 0
  }
}
