import SwiftSyntax

struct AccessModifiers {

  enum Value: String {
    case `private`
    case `fileprivate`
    case `internal`
    case `public`
    case open
  }

  // It is possible to have 'set' without 'get'!
  //   private(set) let elsa: String
  // means that 'get' is internal
  let get: Value?
  let set: Value?
}

/// Modifier that is not an access modifier
///
/// https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID381
enum Modifier: String {
  case `class`
  case convenience
  case dynamic
  case indirect
  case final
  case lazy
  case mutating
  case nonmutating
  case optional
  case override
  case required
  case `static`
  case unowned
  /// case unowned(safe)
  case unownedSafe
  /// case unowned(unsafe)
  case unownedUnsafe
  case weak
}

enum ParseModifiers {

  enum SingleResult {
    case accessModifier(AccessModifiers.Value)
    case accessModifierWithSet(AccessModifiers.Value)
    case operatorKind(Operator.Kind)
    case modifier(Modifier)
  }

  static func single(_ node: DeclModifierSyntax) -> SingleResult {
    let text = node.name.text.trimmed
    // detailText = 'set' inside 'private(set)'
    let detailText = node.detail?.text.trimmed

    if let value = AccessModifiers.Value(rawValue: text) {
      switch detailText {
      case .none:
        return .accessModifier(value)
      case .some(let detailText):
        assert(detailText == "set")
        return .accessModifierWithSet(value)
      }
    }

    if let value = Operator.Kind(rawValue: text) {
      return .operatorKind(value)
    }

    if let value = Modifier(rawValue: text) {
      // Only 'unowned(safe)' or 'unowned(unsafe)' can have 'detailText'
      switch detailText {
      case .none:
        return .modifier(value)
      case .some("safe"):
        assert(value == .unowned)
        return .modifier(.unownedSafe)
      case .some("unsafe"):
        assert(value == .unowned)
        return .modifier(.unownedUnsafe)
      case .some(let detailText):
        fatalError("Unknown '\(text)' modifier detail: '\(detailText)'")
      }
    }

    fatalError("Unknown modifier: '\(text)'!")
  }

  struct ListResult {
    fileprivate(set) var access: AccessModifiers?
    fileprivate(set) var operatorKind: Operator.Kind?
    fileprivate(set) var values = [Modifier]()
  }

  static func list(_ node: ModifierListSyntax?) -> ListResult {
    var result = ListResult()

    guard let node = node else {
      return result
    }

    for modifier in node {
      let oldAccessGet = result.access?.get
      let oldAccessSet = result.access?.set

      switch Self.single(modifier) {
      case let .accessModifier(value):
        assert(oldAccessGet == nil)
        result.access = AccessModifiers(get: value, set: oldAccessSet)
      case let .accessModifierWithSet(value):
        assert(oldAccessSet == nil)
        result.access = AccessModifiers(get: oldAccessGet, set: value)
      case let .operatorKind(value):
        assert(result.operatorKind == nil)
        result.operatorKind = value
      case let .modifier(value):
        result.values.append(value)
      }
    }

    return result
  }
}
