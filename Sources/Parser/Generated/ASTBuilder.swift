// This file was auto-generated by Elsa from 'ast.letitgo.'
// DO NOT EDIT!

import VioletCore
import Foundation

// swiftlint:disable file_length
// swiftlint:disable trailing_newline
// swiftlint:disable function_parameter_count
// swiftlint:disable vertical_whitespace_closing_braces

/// Helper for creating AST nodes with increasing id.
public struct ASTBuilder {

  /// See `ASTNodeId` doc.
  public private(set) var nextId: ASTNodeId = 0

  private mutating func getNextId() -> ASTNodeId {
    let max = ASTNodeId.max
    guard self.nextId != max else {
      trap("ASTBuilder: Reached maximum number of AST nodes: (\(max)).")
    }

    let result = self.nextId
    self.nextId += 1
    return result
  }

  public init() { }

  // MARK: - InteractiveAST

  public mutating func interactiveAST(
    statements: [Statement],
    start: SourceLocation,
    end: SourceLocation
  ) -> InteractiveAST {
    return InteractiveAST(
      id: self.getNextId(),
      statements: statements,
      start: start,
      end: end
    )
  }

  // MARK: - ModuleAST

  public mutating func moduleAST(
    statements: [Statement],
    start: SourceLocation,
    end: SourceLocation
  ) -> ModuleAST {
    return ModuleAST(
      id: self.getNextId(),
      statements: statements,
      start: start,
      end: end
    )
  }

  // MARK: - ExpressionAST

  public mutating func expressionAST(
    expression: Expression,
    start: SourceLocation,
    end: SourceLocation
  ) -> ExpressionAST {
    return ExpressionAST(
      id: self.getNextId(),
      expression: expression,
      start: start,
      end: end
    )
  }

  // MARK: - FunctionDefStmt

  public mutating func functionDefStmt(
    name: String,
    args: Arguments,
    body: NonEmptyArray<Statement>,
    decorators: [Expression],
    returns: Expression?,
    start: SourceLocation,
    end: SourceLocation
  ) -> FunctionDefStmt {
    return FunctionDefStmt(
      id: self.getNextId(),
      name: name,
      args: args,
      body: body,
      decorators: decorators,
      returns: returns,
      start: start,
      end: end
    )
  }

  // MARK: - AsyncFunctionDefStmt

  public mutating func asyncFunctionDefStmt(
    name: String,
    args: Arguments,
    body: NonEmptyArray<Statement>,
    decorators: [Expression],
    returns: Expression?,
    start: SourceLocation,
    end: SourceLocation
  ) -> AsyncFunctionDefStmt {
    return AsyncFunctionDefStmt(
      id: self.getNextId(),
      name: name,
      args: args,
      body: body,
      decorators: decorators,
      returns: returns,
      start: start,
      end: end
    )
  }

  // MARK: - ClassDefStmt

  public mutating func classDefStmt(
    name: String,
    bases: [Expression],
    keywords: [KeywordArgument],
    body: NonEmptyArray<Statement>,
    decorators: [Expression],
    start: SourceLocation,
    end: SourceLocation
  ) -> ClassDefStmt {
    return ClassDefStmt(
      id: self.getNextId(),
      name: name,
      bases: bases,
      keywords: keywords,
      body: body,
      decorators: decorators,
      start: start,
      end: end
    )
  }

  // MARK: - ReturnStmt

  public mutating func returnStmt(
    value: Expression?,
    start: SourceLocation,
    end: SourceLocation
  ) -> ReturnStmt {
    return ReturnStmt(
      id: self.getNextId(),
      value: value,
      start: start,
      end: end
    )
  }

  // MARK: - DeleteStmt

  public mutating func deleteStmt(
    values: NonEmptyArray<Expression>,
    start: SourceLocation,
    end: SourceLocation
  ) -> DeleteStmt {
    return DeleteStmt(
      id: self.getNextId(),
      values: values,
      start: start,
      end: end
    )
  }

  // MARK: - AssignStmt

  public mutating func assignStmt(
    targets: NonEmptyArray<Expression>,
    value: Expression,
    start: SourceLocation,
    end: SourceLocation
  ) -> AssignStmt {
    return AssignStmt(
      id: self.getNextId(),
      targets: targets,
      value: value,
      start: start,
      end: end
    )
  }

  // MARK: - AugAssignStmt

  public mutating func augAssignStmt(
    target: Expression,
    op: BinaryOpExpr.Operator,
    value: Expression,
    start: SourceLocation,
    end: SourceLocation
  ) -> AugAssignStmt {
    return AugAssignStmt(
      id: self.getNextId(),
      target: target,
      op: op,
      value: value,
      start: start,
      end: end
    )
  }

  // MARK: - AnnAssignStmt

  public mutating func annAssignStmt(
    target: Expression,
    annotation: Expression,
    value: Expression?,
    isSimple: Bool,
    start: SourceLocation,
    end: SourceLocation
  ) -> AnnAssignStmt {
    return AnnAssignStmt(
      id: self.getNextId(),
      target: target,
      annotation: annotation,
      value: value,
      isSimple: isSimple,
      start: start,
      end: end
    )
  }

  // MARK: - ForStmt

  public mutating func forStmt(
    target: Expression,
    iterable: Expression,
    body: NonEmptyArray<Statement>,
    orElse: [Statement],
    start: SourceLocation,
    end: SourceLocation
  ) -> ForStmt {
    return ForStmt(
      id: self.getNextId(),
      target: target,
      iterable: iterable,
      body: body,
      orElse: orElse,
      start: start,
      end: end
    )
  }

  // MARK: - AsyncForStmt

  public mutating func asyncForStmt(
    target: Expression,
    iterable: Expression,
    body: NonEmptyArray<Statement>,
    orElse: [Statement],
    start: SourceLocation,
    end: SourceLocation
  ) -> AsyncForStmt {
    return AsyncForStmt(
      id: self.getNextId(),
      target: target,
      iterable: iterable,
      body: body,
      orElse: orElse,
      start: start,
      end: end
    )
  }

  // MARK: - WhileStmt

  public mutating func whileStmt(
    test: Expression,
    body: NonEmptyArray<Statement>,
    orElse: [Statement],
    start: SourceLocation,
    end: SourceLocation
  ) -> WhileStmt {
    return WhileStmt(
      id: self.getNextId(),
      test: test,
      body: body,
      orElse: orElse,
      start: start,
      end: end
    )
  }

  // MARK: - IfStmt

  public mutating func ifStmt(
    test: Expression,
    body: NonEmptyArray<Statement>,
    orElse: [Statement],
    start: SourceLocation,
    end: SourceLocation
  ) -> IfStmt {
    return IfStmt(
      id: self.getNextId(),
      test: test,
      body: body,
      orElse: orElse,
      start: start,
      end: end
    )
  }

  // MARK: - WithItem

  public mutating func withItem(
    contextExpr: Expression,
    optionalVars: Expression?,
    start: SourceLocation,
    end: SourceLocation
  ) -> WithItem {
    return WithItem(
      id: self.getNextId(),
      contextExpr: contextExpr,
      optionalVars: optionalVars,
      start: start,
      end: end
    )
  }

  // MARK: - WithStmt

  public mutating func withStmt(
    items: NonEmptyArray<WithItem>,
    body: NonEmptyArray<Statement>,
    start: SourceLocation,
    end: SourceLocation
  ) -> WithStmt {
    return WithStmt(
      id: self.getNextId(),
      items: items,
      body: body,
      start: start,
      end: end
    )
  }

  // MARK: - AsyncWithStmt

  public mutating func asyncWithStmt(
    items: NonEmptyArray<WithItem>,
    body: NonEmptyArray<Statement>,
    start: SourceLocation,
    end: SourceLocation
  ) -> AsyncWithStmt {
    return AsyncWithStmt(
      id: self.getNextId(),
      items: items,
      body: body,
      start: start,
      end: end
    )
  }

  // MARK: - ExceptHandler

  public mutating func exceptHandler(
    kind: ExceptHandler.Kind,
    body: NonEmptyArray<Statement>,
    start: SourceLocation,
    end: SourceLocation
  ) -> ExceptHandler {
    return ExceptHandler(
      id: self.getNextId(),
      kind: kind,
      body: body,
      start: start,
      end: end
    )
  }

  // MARK: - RaiseStmt

  public mutating func raiseStmt(
    exception: Expression?,
    cause: Expression?,
    start: SourceLocation,
    end: SourceLocation
  ) -> RaiseStmt {
    return RaiseStmt(
      id: self.getNextId(),
      exception: exception,
      cause: cause,
      start: start,
      end: end
    )
  }

  // MARK: - TryStmt

  public mutating func tryStmt(
    body: NonEmptyArray<Statement>,
    handlers: [ExceptHandler],
    orElse: [Statement],
    finally: [Statement],
    start: SourceLocation,
    end: SourceLocation
  ) -> TryStmt {
    return TryStmt(
      id: self.getNextId(),
      body: body,
      handlers: handlers,
      orElse: orElse,
      finally: finally,
      start: start,
      end: end
    )
  }

  // MARK: - AssertStmt

  public mutating func assertStmt(
    test: Expression,
    msg: Expression?,
    start: SourceLocation,
    end: SourceLocation
  ) -> AssertStmt {
    return AssertStmt(
      id: self.getNextId(),
      test: test,
      msg: msg,
      start: start,
      end: end
    )
  }

  // MARK: - Alias

  public mutating func alias(
    name: String,
    asName: String?,
    start: SourceLocation,
    end: SourceLocation
  ) -> Alias {
    return Alias(
      id: self.getNextId(),
      name: name,
      asName: asName,
      start: start,
      end: end
    )
  }

  // MARK: - ImportStmt

  public mutating func importStmt(
    names: NonEmptyArray<Alias>,
    start: SourceLocation,
    end: SourceLocation
  ) -> ImportStmt {
    return ImportStmt(
      id: self.getNextId(),
      names: names,
      start: start,
      end: end
    )
  }

  // MARK: - ImportFromStmt

  public mutating func importFromStmt(
    moduleName: String?,
    names: NonEmptyArray<Alias>,
    level: UInt8,
    start: SourceLocation,
    end: SourceLocation
  ) -> ImportFromStmt {
    return ImportFromStmt(
      id: self.getNextId(),
      moduleName: moduleName,
      names: names,
      level: level,
      start: start,
      end: end
    )
  }

  // MARK: - ImportFromStarStmt

  public mutating func importFromStarStmt(
    moduleName: String?,
    level: UInt8,
    start: SourceLocation,
    end: SourceLocation
  ) -> ImportFromStarStmt {
    return ImportFromStarStmt(
      id: self.getNextId(),
      moduleName: moduleName,
      level: level,
      start: start,
      end: end
    )
  }

  // MARK: - GlobalStmt

  public mutating func globalStmt(
    identifiers: NonEmptyArray<String>,
    start: SourceLocation,
    end: SourceLocation
  ) -> GlobalStmt {
    return GlobalStmt(
      id: self.getNextId(),
      identifiers: identifiers,
      start: start,
      end: end
    )
  }

  // MARK: - NonlocalStmt

  public mutating func nonlocalStmt(
    identifiers: NonEmptyArray<String>,
    start: SourceLocation,
    end: SourceLocation
  ) -> NonlocalStmt {
    return NonlocalStmt(
      id: self.getNextId(),
      identifiers: identifiers,
      start: start,
      end: end
    )
  }

  // MARK: - ExprStmt

  public mutating func exprStmt(
    expression: Expression,
    start: SourceLocation,
    end: SourceLocation
  ) -> ExprStmt {
    return ExprStmt(
      id: self.getNextId(),
      expression: expression,
      start: start,
      end: end
    )
  }

  // MARK: - PassStmt

  public mutating func passStmt(
    start: SourceLocation,
    end: SourceLocation
  ) -> PassStmt {
    return PassStmt(
      id: self.getNextId(),
      start: start,
      end: end
    )
  }

  // MARK: - BreakStmt

  public mutating func breakStmt(
    start: SourceLocation,
    end: SourceLocation
  ) -> BreakStmt {
    return BreakStmt(
      id: self.getNextId(),
      start: start,
      end: end
    )
  }

  // MARK: - ContinueStmt

  public mutating func continueStmt(
    start: SourceLocation,
    end: SourceLocation
  ) -> ContinueStmt {
    return ContinueStmt(
      id: self.getNextId(),
      start: start,
      end: end
    )
  }

  // MARK: - TrueExpr

  public mutating func trueExpr(
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> TrueExpr {
    return TrueExpr(
      id: self.getNextId(),
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - FalseExpr

  public mutating func falseExpr(
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> FalseExpr {
    return FalseExpr(
      id: self.getNextId(),
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - NoneExpr

  public mutating func noneExpr(
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> NoneExpr {
    return NoneExpr(
      id: self.getNextId(),
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - EllipsisExpr

  public mutating func ellipsisExpr(
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> EllipsisExpr {
    return EllipsisExpr(
      id: self.getNextId(),
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - IdentifierExpr

  public mutating func identifierExpr(
    value: String,
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> IdentifierExpr {
    return IdentifierExpr(
      id: self.getNextId(),
      value: value,
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - StringExpr

  public mutating func stringExpr(
    value: StringExpr.Group,
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> StringExpr {
    return StringExpr(
      id: self.getNextId(),
      value: value,
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - IntExpr

  public mutating func intExpr(
    value: BigInt,
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> IntExpr {
    return IntExpr(
      id: self.getNextId(),
      value: value,
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - FloatExpr

  public mutating func floatExpr(
    value: Double,
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> FloatExpr {
    return FloatExpr(
      id: self.getNextId(),
      value: value,
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - ComplexExpr

  public mutating func complexExpr(
    real: Double,
    imag: Double,
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> ComplexExpr {
    return ComplexExpr(
      id: self.getNextId(),
      real: real,
      imag: imag,
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - BytesExpr

  public mutating func bytesExpr(
    value: Data,
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> BytesExpr {
    return BytesExpr(
      id: self.getNextId(),
      value: value,
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - UnaryOpExpr

  public mutating func unaryOpExpr(
    op: UnaryOpExpr.Operator,
    right: Expression,
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> UnaryOpExpr {
    return UnaryOpExpr(
      id: self.getNextId(),
      op: op,
      right: right,
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - BinaryOpExpr

  public mutating func binaryOpExpr(
    op: BinaryOpExpr.Operator,
    left: Expression,
    right: Expression,
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> BinaryOpExpr {
    return BinaryOpExpr(
      id: self.getNextId(),
      op: op,
      left: left,
      right: right,
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - BoolOpExpr

  public mutating func boolOpExpr(
    op: BoolOpExpr.Operator,
    left: Expression,
    right: Expression,
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> BoolOpExpr {
    return BoolOpExpr(
      id: self.getNextId(),
      op: op,
      left: left,
      right: right,
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - CompareExpr

  public mutating func compareExpr(
    left: Expression,
    elements: NonEmptyArray<CompareExpr.Element>,
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> CompareExpr {
    return CompareExpr(
      id: self.getNextId(),
      left: left,
      elements: elements,
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - TupleExpr

  public mutating func tupleExpr(
    elements: [Expression],
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> TupleExpr {
    return TupleExpr(
      id: self.getNextId(),
      elements: elements,
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - ListExpr

  public mutating func listExpr(
    elements: [Expression],
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> ListExpr {
    return ListExpr(
      id: self.getNextId(),
      elements: elements,
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - DictionaryExpr

  public mutating func dictionaryExpr(
    elements: [DictionaryExpr.Element],
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> DictionaryExpr {
    return DictionaryExpr(
      id: self.getNextId(),
      elements: elements,
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - SetExpr

  public mutating func setExpr(
    elements: [Expression],
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> SetExpr {
    return SetExpr(
      id: self.getNextId(),
      elements: elements,
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - Comprehension

  public mutating func comprehension(
    target: Expression,
    iterable: Expression,
    ifs: [Expression],
    isAsync: Bool,
    start: SourceLocation,
    end: SourceLocation
  ) -> Comprehension {
    return Comprehension(
      id: self.getNextId(),
      target: target,
      iterable: iterable,
      ifs: ifs,
      isAsync: isAsync,
      start: start,
      end: end
    )
  }

  // MARK: - ListComprehensionExpr

  public mutating func listComprehensionExpr(
    element: Expression,
    generators: NonEmptyArray<Comprehension>,
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> ListComprehensionExpr {
    return ListComprehensionExpr(
      id: self.getNextId(),
      element: element,
      generators: generators,
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - SetComprehensionExpr

  public mutating func setComprehensionExpr(
    element: Expression,
    generators: NonEmptyArray<Comprehension>,
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> SetComprehensionExpr {
    return SetComprehensionExpr(
      id: self.getNextId(),
      element: element,
      generators: generators,
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - DictionaryComprehensionExpr

  public mutating func dictionaryComprehensionExpr(
    key: Expression,
    value: Expression,
    generators: NonEmptyArray<Comprehension>,
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> DictionaryComprehensionExpr {
    return DictionaryComprehensionExpr(
      id: self.getNextId(),
      key: key,
      value: value,
      generators: generators,
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - GeneratorExpr

  public mutating func generatorExpr(
    element: Expression,
    generators: NonEmptyArray<Comprehension>,
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> GeneratorExpr {
    return GeneratorExpr(
      id: self.getNextId(),
      element: element,
      generators: generators,
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - AwaitExpr

  public mutating func awaitExpr(
    value: Expression,
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> AwaitExpr {
    return AwaitExpr(
      id: self.getNextId(),
      value: value,
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - YieldExpr

  public mutating func yieldExpr(
    value: Expression?,
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> YieldExpr {
    return YieldExpr(
      id: self.getNextId(),
      value: value,
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - YieldFromExpr

  public mutating func yieldFromExpr(
    value: Expression,
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> YieldFromExpr {
    return YieldFromExpr(
      id: self.getNextId(),
      value: value,
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - LambdaExpr

  public mutating func lambdaExpr(
    args: Arguments,
    body: Expression,
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> LambdaExpr {
    return LambdaExpr(
      id: self.getNextId(),
      args: args,
      body: body,
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - CallExpr

  public mutating func callExpr(
    function: Expression,
    args: [Expression],
    keywords: [KeywordArgument],
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> CallExpr {
    return CallExpr(
      id: self.getNextId(),
      function: function,
      args: args,
      keywords: keywords,
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - AttributeExpr

  public mutating func attributeExpr(
    object: Expression,
    name: String,
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> AttributeExpr {
    return AttributeExpr(
      id: self.getNextId(),
      object: object,
      name: name,
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - Slice

  public mutating func slice(
    kind: Slice.Kind,
    start: SourceLocation,
    end: SourceLocation
  ) -> Slice {
    return Slice(
      id: self.getNextId(),
      kind: kind,
      start: start,
      end: end
    )
  }

  // MARK: - SubscriptExpr

  public mutating func subscriptExpr(
    object: Expression,
    slice: Slice,
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> SubscriptExpr {
    return SubscriptExpr(
      id: self.getNextId(),
      object: object,
      slice: slice,
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - IfExpr

  public mutating func ifExpr(
    test: Expression,
    body: Expression,
    orElse: Expression,
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> IfExpr {
    return IfExpr(
      id: self.getNextId(),
      test: test,
      body: body,
      orElse: orElse,
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - StarredExpr

  public mutating func starredExpr(
    expression: Expression,
    context: ExpressionContext,
    start: SourceLocation,
    end: SourceLocation
  ) -> StarredExpr {
    return StarredExpr(
      id: self.getNextId(),
      expression: expression,
      context: context,
      start: start,
      end: end
    )
  }

  // MARK: - Arguments

  public mutating func arguments(
    args: [Argument],
    defaults: [Expression],
    vararg: Vararg,
    kwOnlyArgs: [Argument],
    kwOnlyDefaults: [Expression],
    kwarg: Argument?,
    start: SourceLocation,
    end: SourceLocation
  ) -> Arguments {
    return Arguments(
      id: self.getNextId(),
      args: args,
      defaults: defaults,
      vararg: vararg,
      kwOnlyArgs: kwOnlyArgs,
      kwOnlyDefaults: kwOnlyDefaults,
      kwarg: kwarg,
      start: start,
      end: end
    )
  }

  // MARK: - Argument

  public mutating func argument(
    name: String,
    annotation: Expression?,
    start: SourceLocation,
    end: SourceLocation
  ) -> Argument {
    return Argument(
      id: self.getNextId(),
      name: name,
      annotation: annotation,
      start: start,
      end: end
    )
  }

  // MARK: - KeywordArgument

  public mutating func keywordArgument(
    kind: KeywordArgument.Kind,
    value: Expression,
    start: SourceLocation,
    end: SourceLocation
  ) -> KeywordArgument {
    return KeywordArgument(
      id: self.getNextId(),
      kind: kind,
      value: value,
      start: start,
      end: end
    )
  }

}

