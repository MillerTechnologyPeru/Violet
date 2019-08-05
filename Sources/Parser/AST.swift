// This file was auto-generated by Elsa from 'ast.letitgo' using 'ast' command.
// DO NOT EDIT!

import Foundation
import Core
import Lexer

// swiftlint:disable file_length
// swiftlint:disable line_length
// swiftlint:disable trailing_newline

/// https://docs.python.org/3/reference/expressions.html
public struct Expression: Equatable {

  /// Type of the expression.
  public let kind: ExpressionKind
  /// Location of the first character in the source code.
  public let start: SourceLocation
  /// Location just after the last character in the source code.
  public let end: SourceLocation

  public init(kind: ExpressionKind, start: SourceLocation, end: SourceLocation) {
    self.kind = kind
    self.start = start
    self.end = end
  }
}

/// https://docs.python.org/3/reference/expressions.html
public indirect enum ExpressionKind: Equatable {
  case `true`
  case `false`
  case none
  case ellipsis
  case identifier(String)
  case int(PyInt)
  case float(Double)
  case complex(real: Double, imag: Double)
  case bytes(Data)
  /// Operation with single operand.
  case unaryOp(UnaryOperator, right: Expression)
  /// Operation with 2 operands.
  case binaryOp(BinaryOperator, left: Expression, right: Expression)
  /// Operation with logical values as operands.
  /// Returns last evaluated argument (even if it's not strictly `True` or `False`).
  /// - Note:
  /// Following values are interpreted as false:
  /// - False
  /// - None
  /// - numeric zero
  /// - empty strings
  /// - empty containers
  case boolOp(BooleanOperator, left: Expression, right: Expression)
  case compare(left: Expression, elements: [ComparisonElement])
  /// Values separated by commas (sometimes between parentheses): (a,b).
  case tuple([Expression])
  /// List of comma-separated values between square brackets: [a,b].
  case list([Expression])
  /// Set of `key: value` pairs between braces: {a: b}. Keys are unique.
  case dictionary([DictionaryElement])
  /// List of comma-separated values between braces: {a}. Unordered with no duplicates.
  case set([Expression])
  /// Brackets containing an expression followed by a for clause and then
  /// zero or more for or if clauses.
  /// `elt` - expression that will be evaluated for each item
  case listComprehension(elt: Expression, generators: [Comprehension])
  /// Brackets containing an expression followed by a for clause and then
  /// zero or more for or if clauses.
  /// `elt` - expression that will be evaluated for each item
  case setComprehension(elt: Expression, generators: [Comprehension])
  /// Brackets containing an expression followed by a for clause and then
  /// zero or more for or if clauses.
  /// `key` and `value` - expressions that will be evaluated for each item
  case dictionaryComprehension(key: Expression, value: Expression, generators: [Comprehension])
  /// Expression followed by a for clause and then
  /// zero or more for or if clauses.
  /// `elt` - expression that will be evaluated for each item
  case generatorExp(elt: Expression, generators: [Comprehension])
  case await(Expression)
  case yield(Expression?)
  case yieldFrom(Expression)
  case lambda(args: Arguments, body: Expression)
  /// A function call.
  /// - `func` - function to call
  /// - `args` - arguments passed by position
  /// - `keywords` - keyword objects representing arguments passed by keyword
  case call(func: Expression, args: [Expression], keywords: [Keyword])
  case namedExpr(target: Expression, value: Expression)
  case ifExpression(test: Expression, body: Expression, orElse: Expression)
  case attribute(Expression, name: String)
  case `subscript`(Expression, slice: Slice)
  case starred(Expression)
}

public enum UnaryOperator: Equatable {
  /// Bitwise inversion of its integer argument.
  /// Only applies to integral numbers.
  case invert
  /// True if its argument is false, False otherwise.
  case not
  /// Unchanged argument. CPython: UAdd (unary add).
  case plus
  /// Negation of its numeric argument. CPython: USub (unary sub).
  case minus
}

public enum BooleanOperator: Equatable {
  /// Logical `and` with short-circuit.
  case and
  /// Logical `or` with short-circuit.
  case or
}

public enum BinaryOperator: Equatable {
  /// Sum of its arguments.
  /// - Numbers added together.
  /// - Sequences are concatenated.
  case add
  /// Difference of its arguments.
  case sub
  /// Product of its arguments.
  /// - Numbers multiplied together.
  /// - For integer and sequence repetition is performed.
  case mul
  /// Intended to be used for matrix multiplication.
  /// No builtin Python types implement this operator.
  case matMul
  /// Quotient of their arguments.
  /// Division of integers yields a float.
  case div
  /// Remainder from the division of the first argument by the second.
  case modulo
  /// Left argument raised to the power of its right argument.
  case pow
  /// Shift the first argument to the left by the number of bits
  /// given by the second argument.
  case leftShift
  /// Shift the first argument to the right by the number of bits
  /// given by the second argument.
  case rightShift
  /// Bitwise (inclusive) OR of its arguments, which must be integers.
  case bitOr
  /// Bitwise XOR (exclusive OR) of its arguments, which must be integers.
  case bitXor
  /// Bitwise AND of its arguments, which must be integers.
  case bitAnd
  /// Quotient of their arguments.
  /// Floor division of integers results in an integer.
  case floorDiv
}

public struct ComparisonElement: Equatable {

  public let op: ComparisonOperator
  public let right: Expression

  public init(op: ComparisonOperator, right: Expression) {
    self.op = op
    self.right = right
  }
}

public enum ComparisonOperator: Equatable {
  /// True when two operands are equal.
  case equal
  /// True when two operands are not equal.
  case notEqual
  /// True when left operand is less than the value of right operand.
  case less
  /// True when left operand is less than or equal to the value of right operand.
  case lessEqual
  /// True when left operand is greater than the value of right operand.
  case greater
  /// True when left operand is greater than or equal to the value of right operand.
  case greaterEqual
  /// True when x and y are the same object.
  case `is`
  /// Negation of `x is y`.
  case isNot
  /// True when x is a member of s.
  case `in`
  /// Negation of `x in s`
  case notIn
}

public enum DictionaryElement: Equatable {
  /// `**expr`
  case unpacking(Expression)
  /// `key : value`
  case keyValue(key: Expression, value: Expression)
}

/// Transforms a value prior to formatting it.
public enum ConversionFlag: Equatable {
  /// Converts by calling `str(<value>)`.
  case str
  /// Converts by calling `ascii(<value>)`.
  case ascii
  /// Converts by calling `repr(<value>)`.
  case repr
}

public struct Slice: Equatable {

  public let kind: SliceKind
  /// Location of the first character in the source code.
  public let start: SourceLocation
  /// Location just after the last character in the source code.
  public let end: SourceLocation

  public init(kind: SliceKind, start: SourceLocation, end: SourceLocation) {
    self.kind = kind
    self.start = start
    self.end = end
  }
}

public enum SliceKind: Equatable {
  /// Regular slicing: `movies[pinocchio:frozen2]`.
  case slice(lower: Expression?, upper: Expression?, step: Expression?)
  /// Advanced slicing: `frozen[kristoff:ana, olaf]`.
  /// `dims` holds a list of `Slice` and `Index` nodes.
  case extSlice(dims: [Slice])
  /// Subscripting with a single value: `frozen[elsa]`.
  case index(Expression)
}

/// One `for` clause in a comprehension.
public struct Comprehension: Equatable {

  /// Reference to use for each element,
  /// typically a `Identifier` or `Tuple` node.
  public let target: Expression
  /// Object to iterate over.
  public let iter: Expression
  /// List of test expressions. We can have multiple `ifs`.
  public let ifs: [Expression]
  /// Indicates that the comprehension is asynchronous.
  public let isAsync: Bool
  /// Location of the first character in the source code.
  public let start: SourceLocation
  /// Location just after the last character in the source code.
  public let end: SourceLocation

  public init(target: Expression, iter: Expression, ifs: [Expression], isAsync: Bool, start: SourceLocation, end: SourceLocation) {
    self.target = target
    self.iter = iter
    self.ifs = ifs
    self.isAsync = isAsync
    self.start = start
    self.end = end
  }
}

/// The arguments for a function passed by value
/// (where the value is always an object reference, not the value of the object).
/// https://docs.python.org/3/tutorial/controlflow.html#more-on-defining-functions"
public struct Arguments: Equatable {

  /// Function positional arguments.
  /// When a function is called, positional arguments are mapped
  /// to these parameters based solely on their position.
  public let args: [Arg]
  /// Default values for positional arguments.
  /// If there are fewer defaults, they correspond to the last *n* arguments.
  /// - Important: The default value is evaluated only **once**.
  public let defaults: [Expression]
  /// Non-keyworded variable length arguments.
  /// By convention called `*args`.
  public let vararg: Vararg
  /// Parameters which occur after the '*args'.
  /// Can only be used as keywords rather than positional arguments.
  /// CPython `kwonlyargs`.
  public let kwOnlyArgs: [Arg]
  /// Default values for keyword-only arguments.
  /// If no default value is specified then implicit `None` is assumed.
  /// CPython `kw_defaults`.
  /// - Important: The default value is evaluated only **once**.
  public let kwOnlyDefaults: [Expression]
  /// Keyworded (named) variable length arguments.
  /// By convention called `**kwargs`.
  public let kwarg: Arg?
  /// Location of the first character in the source code.
  public let start: SourceLocation
  /// Location just after the last character in the source code.
  public let end: SourceLocation

  public init(args: [Arg], defaults: [Expression], vararg: Vararg, kwOnlyArgs: [Arg], kwOnlyDefaults: [Expression], kwarg: Arg?, start: SourceLocation, end: SourceLocation) {
    self.args = args
    self.defaults = defaults
    self.vararg = vararg
    self.kwOnlyArgs = kwOnlyArgs
    self.kwOnlyDefaults = kwOnlyDefaults
    self.kwarg = kwarg
    self.start = start
    self.end = end
  }
}

public struct Arg: Equatable {

  /// Argument name.
  public let name: String
  /// Python expression evaluated at compile time.
  /// Not used during runtime, can be used by third party libraries.
  /// Introduced in PEP 3107.
  public let annotation: Expression?
  /// Location of the first character in the source code.
  public let start: SourceLocation
  /// Location just after the last character in the source code.
  public let end: SourceLocation

  public init(name: String, annotation: Expression?, start: SourceLocation, end: SourceLocation) {
    self.name = name
    self.annotation = annotation
    self.start = start
    self.end = end
  }
}

public enum Vararg: Equatable {
  case none
  /// Separator for keyword arguments. Represented by just `*`.
  case unnamed
  case named(Arg)
}

/// A keyword argument to a function call or class definition.
/// `nil` name is used for `**kwargs`.
public struct Keyword: Equatable {

  /// Parameter name.
  public let name: String?
  /// Node to pass in.
  public let value: Expression
  /// Location of the first character in the source code.
  public let start: SourceLocation
  /// Location just after the last character in the source code.
  public let end: SourceLocation

  public init(name: String?, value: Expression, start: SourceLocation, end: SourceLocation) {
    self.name = name
    self.value = value
    self.start = start
    self.end = end
  }
}

