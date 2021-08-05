import SwiftSyntax

struct Attribute {

  let name: String

  init(_ node: Syntax) {
    let children = Array(node.children)
    assert(children.count >= 2)

    let first = children[0]
    assert(first.isToken(withText: "@"))

    let second = children[1]
    let name = second.description.trimmed

    // Something like: @discardableResult
    if children.count == 2 {
      self.name = name
      return
    }

    // @available(*, deprecated)
    if children.count == 5 {
      assert(children[2].isToken(withText: "("))
      assert(children[4].isToken(withText: ")"))
      // let arguments = children[3] // AvailabilitySpecListSyntax
      self.name = name
      return
    }

    fatalError("Unknown attribute shape!")
  }
}
