import Foundation
import XCTest
import Core
import Lexer
@testable import Parser

// Use this for reference:
// https://www.youtube.com/watch?v=BTBaUHSi-xk
// The beginning it rather discouraging, but it gets easier later.

class FStringParserTest: XCTestCase, DestructStringGroup {

  // MARK: - Empty

  func test_empty() throws {
    var string = self.createFString()

    let group = try string.compile()
    if let result = self.destructStringSimple(group) {
      XCTAssertEqual(result, "")
    }
  }

  // MARK: - String

  func test_string() throws {
    let s = "The snow glows white on the mountain tonight"

    var string = self.createFString()
    try string.append(s)

    let group = try string.compile()
    if let result = self.destructStringSimple(group) {
      XCTAssertEqual(result, s)
    }
  }

  func test_string_concatentation() throws {
    var string = self.createFString()
    try string.append("Not a footprint to be seen\n")
    try string.append("A kingdom of isolation\n")
    try string.append("And it looks like I'm the queen")

    let expected = """
      Not a footprint to be seen
      A kingdom of isolation
      And it looks like I'm the queen
      """

    let group = try string.compile()
    if let result = self.destructStringSimple(group) {
      XCTAssertEqual(result, expected)
    }
  }

  // MARK: - FString - literals

  func test_literal() throws {
    let s = "The wind is howling like this swirling storm inside"

    var string = self.createFString()
    try string.appendFormatString(s)

    let group = try string.compile()
    if let result = self.destructStringSimple(group) {
      XCTAssertEqual(result, s)
    }
  }

  func test_literal_withEscapes() throws {
    let s = "Couldn't keep {{it}} in, heaven knows I tried!"
    let expected = "Couldn't keep {it} in, heaven knows I tried!"

    var string = self.createFString()
    try string.appendFormatString(s)

    let group = try string.compile()
    if let result = self.destructStringSimple(group) {
      XCTAssertEqual(result, expected)
    }
  }

  func test_literal_withUnclosedEscapeAtEnd_throws() throws {
    let s = "Don't let them in, don't let them see{"

    do {
      var string = self.createFString()
      try string.appendFormatString(s)
      XCTAssert(false)
    } catch let error as FStringError {
      XCTAssertEqual(error, FStringError.unexpectedEnd)
    } catch {
      XCTAssert(false, "\(error)")
    }
  }

  func test_literal_withSingleRightBrace_throws() throws {
    let s = "Be the good girl }you always have to be"

    do {
      var string = self.createFString()
      try string.appendFormatString(s)
      XCTAssert(false)
    } catch let error as FStringError {
      XCTAssertEqual(error, FStringError.singleRightBrace)
    } catch {
      XCTAssert(false, "\(error)")
    }
  }

  func test_literal_conat() throws {
    var string = self.createFString()
    try string.appendFormatString("Conceal, don't feel, don't let them know\n")
    try string.appendFormatString("Well, now they know!")

    let expected = """
      Conceal, don't feel, don't let them know
      Well, now they know!
      """

    let group = try string.compile()
    if let result = self.destructStringSimple(group) {
      XCTAssertEqual(result, expected)
    }
  }

  // MARK: - Fstring - formatted value

  func test_formattedValue() throws {
    var string = self.createFString()
    try string.appendFormatString("{2013}")

    let group = try string.compile()
    if let d = self.destructStringFormattedValue(group) {
      XCTAssertEqual(d.0, "2013")
      XCTAssertEqual(d.conversion, nil)
      XCTAssertEqual(d.spec, nil)
    }
  }

  func test_formattedValue_string() throws {
    var string = self.createFString()
    try string.appendFormatString("{'Let it go, let it go'}")

    let group = try string.compile()
    if let d = self.destructStringFormattedValue(group) {
      XCTAssertEqual(d.0, "'Let it go, let it go'")
      XCTAssertEqual(d.conversion, nil)
      XCTAssertEqual(d.spec, nil)
    }
  }

  func test_formattedValue_inParens() throws {
    var string = self.createFString()
    try string.appendFormatString("{('Cant hold it back anymore')}")

    let group = try string.compile()
    if let d = self.destructStringFormattedValue(group) {
      XCTAssertEqual(d.0, "('Cant hold it back anymore')")
      XCTAssertEqual(d.conversion, nil)
      XCTAssertEqual(d.spec, nil)
    }
  }

  func test_formattedValue_conversion() throws {
    var string = self.createFString()
    try string.appendFormatString("{'Let it go, let it go'!r}")

    let group = try string.compile()
    if let d = self.destructStringFormattedValue(group) {
      XCTAssertEqual(d.0, "'Let it go, let it go'")
      XCTAssertEqual(d.conversion, .repr)
      XCTAssertEqual(d.spec, nil)
    }
  }

  func test_formattedValue_formatSpec() throws {
    var string = self.createFString()
    try string.appendFormatString("{'Let it go, let it go':^30}")

    let group = try string.compile()
    if let d = self.destructStringFormattedValue(group) {
      XCTAssertEqual(d.0, "'Let it go, let it go'")
      XCTAssertEqual(d.conversion, nil)
      XCTAssertEqual(d.spec, "^30")
    }
  }

  func test_formattedValue_conversion_formatSpec() throws {
    var string = self.createFString()
    try string.appendFormatString("{'Turn away and slam the door!'!a:^30}")

    let group = try string.compile()
    if let d = self.destructStringFormattedValue(group) {
      XCTAssertEqual(d.0, "'Turn away and slam the door!'")
      XCTAssertEqual(d.conversion, .ascii)
      XCTAssertEqual(d.spec, "^30")
    }
  }

  // MARK: - FString - joined

  // start
  // middle
  // end

  // parens
  // spaces before after expression
  // multiline/long string

  // backslashInExpression
  // commentInExpression
  // != in expression

  // formats etc

  // MARK: - Helpers

  private func createFString() -> FString {
    return FStringImpl()
  }
}
