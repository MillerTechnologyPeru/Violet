// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import XCTest
import Core
@testable import Lexer

/// Lexer test helpers.
internal protocol LexerTest { }

extension LexerTest {

  // MARK: - Int

  internal func XCTAssertInt(_ kind: TokenKind,
                             _ expected: Int64,
                             file: StaticString = #file,
                             line: UInt         = #line) {

    let pyExpected = PyInt(expected)
    XCTAssertEqual(kind, .int(pyExpected), file: file, line: line)
  }

  // MARK: - Quotes

  internal func shortQuote(_ s: String, _ q: String = "\"") -> String {
    return "\(q)\(s)\(q)"
  }

  internal func longQuote(_ s: String, _ q: String = "\"") -> String {
    return "\(q)\(q)\(q)\(s)\(q)\(q)\(q)"
  }

  // MARK: - Lex

  internal func identifierOrString(_ lexer: inout Lexer,
                                   file:    StaticString = #file,
                                   line:    UInt         = #line) -> Token? {
    return self.lex(try lexer.identifierOrString(), file: file, line: line)
  }

  internal func string(_ lexer: inout Lexer,
                       file:    StaticString = #file,
                       line:    UInt         = #line) -> Token? {
    return self.lex(try lexer.string(), file: file, line: line)
  }

  internal func number(_ lexer: inout Lexer,
                       file:    StaticString = #file,
                       line:    UInt         = #line) -> Token? {
    return self.lex(try lexer.number(), file: file, line: line)
  }

  private func lex(_ f:  @autoclosure () throws -> Token,
                   file: StaticString = #file,
                   line: UInt         = #line) -> Token? {
    do {
      return try f()
    } catch {
      XCTAssert(false, "\(error)", file: file, line: line)
      return nil
    }
  }

  // MARK: - Lex errors

  internal func identifierOrStringError(_ lexer: inout Lexer,
                                        file:    StaticString = #file,
                                        line:    UInt = #line) -> LexerError? {
    return self.error(try lexer.identifierOrString(), file: file, line: line)
  }

  internal func stringError(_ lexer: inout Lexer,
                            file:    StaticString = #file,
                            line:    UInt = #line) -> LexerError? {
    return self.error(try lexer.string(), file: file, line: line)
  }

  internal func numberError(_ lexer: inout Lexer,
                            file:    StaticString = #file,
                            line:    UInt = #line) -> LexerError? {
    return self.error(try lexer.number(), file: file, line: line)
  }

  private func error(_ f:  @autoclosure () throws -> Token,
                     file: StaticString = #file,
                     line: UInt         = #line) -> LexerError? {
    do {
      let result = try f()
      XCTAssert(false, "Got token: \(result)", file: file, line: line)
      return nil
    } catch let error as LexerError {
      return error
    } catch {
      XCTAssert(false, "Invalid error: \(error)", file: file, line: line)
      return nil
    }
  }
}
