import VioletCore
import VioletParser
import VioletBytecode

internal enum SpecialIdentifiers {
  internal static let `return` = "return"
  internal static let assertionError = "AssertionError"

  internal static let __annotations__ = "__annotations__"
  internal static let __class__ = "__class__"
  internal static let __classcell__ = "__classcell__"
  internal static let __doc__ = "__doc__"
  internal static let __future__ = "__future__"
  internal static let __module__ = "__module__"
  internal static let __name__ = "__name__"
  internal static let __qualname__ = "__qualname__"
}

internal enum BlockType {
  case loop(continueTarget: Label)
  case except
  case finallyTry
  case finallyEnd

  internal var isLoop: Bool {
    switch self {
    case .loop: return true
    case .except, .finallyTry, .finallyEnd: return false
    }
  }
}

/// The following items change on entry and exit of scope.
/// They must be saved and restored when returning to a scope.
internal final class CompilerUnit {

  internal let scope: SymbolScope
  internal let codeObject: CodeObject
  internal let builder: CodeObjectBuilder

  /// Name of the class that we are currently filling (if any).
  /// Mostly used for mangling.
  internal let className: String?

  internal init(scope:      SymbolScope,
                codeObject: CodeObject,
                className:  String?) {
    self.scope = scope
    self.codeObject = codeObject
    self.builder = CodeObjectBuilder(codeObject: codeObject)
    self.className = className
  }
}
