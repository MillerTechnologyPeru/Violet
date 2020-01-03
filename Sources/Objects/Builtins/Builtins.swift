import Core

// In CPython:
// Python -> builtinmodule.c
// https://docs.python.org/3/library/functions.html

public final class Builtins {

  internal static let doc = """
    Built-in functions, exceptions, and other objects.

    Noteworthy: None is the `nil' object; Ellipsis represents `...' in slices.
    """

  public lazy var `true`  = PyBool(self.context, value: true)
  public lazy var `false` = PyBool(self.context, value: false)
  public lazy var none  = PyNone(self.context)
  public lazy var ellipsis = PyEllipsis(self.context)
  public lazy var emptyTuple = PyTuple(self.context, elements: [])
  public lazy var emptyString = self.context.intern("")
  public lazy var emptyFrozenSet = PyFrozenSet(self.context)
  public lazy var notImplemented = PyNotImplemented(self.context)

  public let types: BuiltinTypes
  public let errorTypes: BuiltinErrorTypes

  private weak var _context: PyContext?
  internal var context: PyContext {
    if let c = self._context {
      return c
    }

    fatalError("Trying to use 'sys' module after its context was deallocated.")
  }

  // MARK: - Init

  /// Stage 1: Create all type objects
  ///
  /// 'PyType.init' is not allowed to use any other type!
  /// For example you can't just create `PyString` for `__doc__` etc.
  /// (that is because `str` type may not exist), we will deal with this in
  /// `onContextFullyInitailized`.
  internal init(context: PyContext) {
    self._context = context
    self.types = BuiltinTypes(context: context)
    self.errorTypes = BuiltinErrorTypes(context: context, types: self.types)
  }

  /// Stage 2: Fill type objects
  ///
  /// Now we are allowed to use other types (for example create PyStrings etc.)
  internal func onContextFullyInitailized() {
    self.types.postInit()
    self.errorTypes.postInit()
  }

  // MARK: - Deinit

  internal func onContextDeinit() {
    // Clean circular references.
    // This is VERY IMPORTANT because:
    // 1. 'type' inherits from 'object'
    //    both 'type' and 'object' are instances of 'type'
    // 2. 'Type' type has 'BuiltinFunction' attributes which reference 'Type'.
    for type in self.types.all {
      type.gcClean()
    }

    for type in self.errorTypes.all {
      type.gcClean()
    }
  }
}
