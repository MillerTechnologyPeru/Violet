import XCTest
import VioletCore
import VioletParser
import VioletBytecode
@testable import VioletCompiler

/// Use 'Scripts/dump_dis.py' for reference.
class CompileTuple: CompileTestCase {

  /// ()
  func test_empty() {
    let expr = self.tupleExpr(elements: [])

    guard let code = self.compile(expr: expr) else {
      return
    }

    XCTAssertCodeObject(
      code,
      name: "<module>",
      qualifiedName: "",
      kind: .module,
      flags: [],
      instructions: [
        .buildTuple(elementCount: 0),
        .return
      ]
    )
  }

  /// ('ariel', True)
  func test_constantsOnly() {
    let expr = self.tupleExpr(elements: [
      self.stringExpr(value: .literal("ariel")),
      self.trueExpr()
    ])

    guard let code = self.compile(expr: expr) else {
      return
    }

    XCTAssertCodeObject(
      code,
      name: "<module>",
      qualifiedName: "",
      kind: .module,
      flags: [],
      instructions: [
        .loadConst("ariel"),
        .loadConst(.true),
        .buildTuple(elementCount: 2),
        .return
      ]
    )
  }

  /// (ariel, True)
  func test_withIdentifier() {
    let expr = self.tupleExpr(elements: [
      self.identifierExpr(value: "ariel"),
      self.trueExpr()
    ])

    guard let code = self.compile(expr: expr) else {
      return
    }

    XCTAssertCodeObject(
      code,
      name: "<module>",
      qualifiedName: "",
      kind: .module,
      flags: [],
      instructions: [
        .loadName(name: "ariel"),
        .loadConst(.true),
        .buildTuple(elementCount: 2),
        .return
      ]
    )
  }

  /// (ariel, *sea)
  ///
  /// 0 LOAD_NAME                0 (ariel)
  /// 2 BUILD_TUPLE              1
  /// 4 LOAD_NAME                1 (sea)
  /// 6 BUILD_UNPACK       2
  /// 8 RETURN_VALUE
  func test_withUnpack() {
    let expr = self.tupleExpr(elements: [
      self.identifierExpr(value: "ariel"),
      self.starredExpr(expression: self.identifierExpr(value: "sea"))
    ])

    guard let code = self.compile(expr: expr) else {
      return
    }

    XCTAssertCodeObject(
      code,
      name: "<module>",
      qualifiedName: "",
      kind: .module,
      flags: [],
      instructions: [
        .loadName(name: "ariel"),
        .buildTuple(elementCount: 1),
        .loadName(name: "sea"),
        .buildTupleUnpack(elementCount: 2),
        .return
      ]
    )
  }

  /// (ariel, *sea, *land, eric)
  ///
  ///  0 LOAD_NAME                0 (ariel)
  ///  2 BUILD_TUPLE              1
  ///  4 LOAD_NAME                1 (sea)
  ///  6 LOAD_NAME                2 (land)
  ///  8 LOAD_NAME                3 (eric)
  /// 10 BUILD_TUPLE              1
  /// 12 BUILD_UNPACK       4
  /// 14 RETURN_VALUE
  func test_withUnpack_multiple() {
    let expr = self.tupleExpr(elements: [
      self.identifierExpr(value: "ariel"),
      self.starredExpr(expression: self.identifierExpr(value: "sea")),
      self.starredExpr(expression: self.identifierExpr(value: "land")),
      self.identifierExpr(value: "eric")
    ])

    guard let code = self.compile(expr: expr) else {
      return
    }

    XCTAssertCodeObject(
      code,
      name: "<module>",
      qualifiedName: "",
      kind: .module,
      flags: [],
      instructions: [
        //      .init(.loadName, "ariel"),
        //      .init(.buildTuple, "1"),
        //      .init(.loadName, "sea"),
        //      .init(.loadName, "land"),
        //      .init(.loadName, "eric"),
        //      .init(.buildTuple, "1"),
        //      .init(.buildTupleUnpack, "4"),
        //      .init(.return)

        .loadName(name: "ariel"),
        .buildTuple(elementCount: 1),
        .loadName(name: "sea"),
        .loadName(name: "land"),
        .loadName(name: "eric"),
        .buildTuple(elementCount: 1),
        .buildTupleUnpack(elementCount: 4),
        .return
      ]
    )
  }
}
