import Core

// In CPython:
// Objects -> boolobject.c
// https://docs.python.org/3.7/c-api/bool.html

// TODO: Bool
// def __getnewargs__(self) -> Tuple[int]: ...

extension BigInt {
  internal var isTrue: Bool {
    return self != 0
  }
}

extension Int {
  internal var isTrue: Bool {
    return self != 0
  }
}

// sourcery: pytype = bool
/// Booleans in Python are implemented as a subclass of integers.
/// There are only two booleans, Py_False and Py_True.
/// As such, the normal creation and deletion functions don’t apply to booleans.
internal final class PyBool: PyInt {

//  #warning("internal var base: PyType? { return self.types.int }")

  override internal class var doc: String { return """
    bool(x) -> bool

    Returns True when the argument x is true, False otherwise.
    The builtins True and False are the only two instances of the class bool.
    The class bool is a subclass of the class int, and cannot be subclassed
    """
  }

  // MARK: - Init

  internal init(_ context: PyContext, value: Bool) {
    super.init(type: context.types.bool, value: BigInt(value ? 1 : 0))
  }

  // MARK: - String

  override internal func repr() -> String {
    return self.value.isTrue ? "True" : "False"
  }

  override internal func str() -> String {
    return self.repr()
  }

  // MARK: - And

  override internal func and(_ other: PyObject) -> BinaryResult<PyObject> {
    if let other = other as? PyBool {
      let result = self.value.isTrue && other.value.isTrue
      return .value(self.bool(result))
    }

    return super.and(other)
  }

  override internal func rand(_ other: PyObject) -> BinaryResult<PyObject> {
    return self.and(other)
  }

  // MARK: - Or

  override internal func or(_ other: PyObject) -> BinaryResult<PyObject> {
    if let other = other as? PyBool {
      let result = self.value.isTrue || other.value.isTrue
      return .value(self.bool(result))
    }

    return super.and(other)
  }

  override internal func ror(_ other: PyObject) -> BinaryResult<PyObject> {
    return self.or(other)
  }

  // MARK: - Xor

  override internal func xor(_ other: PyObject) -> BinaryResult<PyObject> {
    if let other = other as? PyBool {
      let result = self.value.isTrue != other.value.isTrue
      return .value(self.bool(result))
    }

    return super.and(other)
  }

  override internal func rxor(_ other: PyObject) -> BinaryResult<PyObject> {
    return self.xor(other)
  }
}
