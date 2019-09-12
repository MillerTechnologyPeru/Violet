import Foundation
import Core
import Lexer

// swiftlint:disable file_length
// swiftlint:disable function_parameter_count

// MARK: - Helpers

private func join<S: Sequence>(_ arr: S, _ separator: String = " ") -> String {
  return arr.map { describe($0) }.joined(separator: separator)
}

private func describe<T>(_ obj: T) -> String {
  return String(describing: obj)
}

private func prefix(_ s: String, length: Int = 5) -> String {
  return s.count > length ? s.prefix(length) + "..." : s
}

// MARK: - Statement

extension Statement: CustomStringConvertible, CustomDebugStringConvertible {
  public var description: String {
    return describe(self.kind)
  }

  public var debugDescription: String {
    return "Statement(\(self.kind), start: \(self.start), end: \(self.end))"
  }
}

extension StatementKind: CustomStringConvertible {
  private func defDescription(header: String,
                              name: String,
                              args: Arguments,
                              body: NonEmptyArray<Statement>,
                              decorators: [Expression],
                              returns: Expression?) -> String {
    let r = returns.map { " -> " + describe($0) } ?? ""
    let d = self.decorators(from: decorators)
    return "(\(header) \(name)\(args)\(r)\(d) do: \(join(body)))"
  }

  private func forDescription(header: String,
                              target: Expression,
                              iter: Expression,
                              body: NonEmptyArray<Statement>,
                              orElse: [Statement]) -> String {
    var b: String?
    switch body.count {
    case 0: b = "()"
    case 1: b = describe(body[0])
    default: b = "(\(join(body)))"
    }

    var e: String?
    switch orElse.count {
    case 0: e = ""
    case 1: e = " else: \(orElse[0])"
    default: e = " else: (\(join(body)))"
    }

    return "(\(header) \(target) in: \(iter) do: \(b ?? "")\(e ?? ""))"
  }

  private func decorators(from decorators: [Expression]) -> String {
    return decorators.isEmpty ? "" :
      " decorators: " + join(decorators.map { "@" + describe($0) })
  }

  public var description: String {
    switch self {

    case let .functionDef(name, args, body, decorators, returns):
      return self.defDescription(header: "def",
                                 name: name,
                                 args: args,
                                 body: body,
                                 decorators: decorators,
                                 returns: returns)
    case let .asyncFunctionDef(name, args, body, decorators, returns):
      return self.defDescription(header: "asyncDef",
                                 name: name,
                                 args: args,
                                 body: body,
                                 decorators: decorators,
                                 returns: returns)

    case let .classDef(name, bases, keywords, body, decorators):
      var parents = ""
      switch (bases.isEmpty, keywords.isEmpty) {
      case (true, true): break
      case (false, true):  parents = " (" + join(bases) + ")"
      case (true, false):  parents = " (" + join(keywords) + ")"
      case (false, false): parents = " (" + join(bases) + " " + join(keywords) + ")"
      }

      let d = self.decorators(from: decorators)
      return "(class \(name)\(parents)\(d) body: \(join(body)))"

    case let .return(value):
      switch value {
      case .none: return "return"
      case .some(let v): return "(return \(describe(v)))"
      }

    case let .delete(v):
      return "(del \(join(v)))"

    case let .assign(targets, value):
      let t = join(targets, " = ")
      return "(\(t) = \(value))"

    case let .annAssign(target, annotation, value, _):
      let v = value.map { " = " + describe($0) } ?? ""
      return "(\(target):\(annotation)\(v))"

    case let .augAssign(target: target, op: op, value: value):
      return "(\(target) \(op)= \(value))"

    case let .for(target, iter, body, orElse):
      return self.forDescription(header: "for",
                                 target: target,
                                 iter: iter,
                                 body: body,
                                 orElse: orElse)
    case let .asyncFor(target, iter, body, orElse):
      return self.forDescription(header: "asyncFor",
                                 target: target,
                                 iter: iter,
                                 body: body,
                                 orElse: orElse)

    case let .while(test, body, orElse):
      var b: String?
      switch body.count {
      case 0: b = "()"
      case 1: b = "do: " + describe(body[0])
      default: b = "do: (\(join(body)))"
      }

      var e: String?
      switch orElse.count {
      case 0: e = ""
      case 1: e = " else: \(orElse[0])"
      default: e = " else: (\(join(body)))"
      }

      return "(while \(test) \(b ?? "")\(e ?? ""))"

    case let .if(test, body, orElse):
      var b: String?
      switch body.count {
      case 0: b = "()"
      case 1: b = describe(body[0])
      default: b = "(\(join(body)))"
      }

      var e: String?
      switch orElse.count {
      case 0: e = ""
      case 1: e = " else: \(orElse[0])"
      default: e = " else: (\(join(body)))"
      }

      return "(if \(test) then: \(b ?? "")\(e ?? ""))"

    case let .with(items, body):
      return "(with \(join(items)) do: \(join(body)))"
    case let .asyncWith(items, body):
      return "(asyncWith \(join(items)) do: \(join(body)))"

    case let .try(body, handlers, orElse, finalBody):
      let h = handlers.isEmpty  ? "" : " " + join(handlers)
      let o = orElse.isEmpty    ? "" : " else: \(join(orElse))"
      let f = finalBody.isEmpty ? "" : " finally: \(join(finalBody))"
      return "(try \(join(body))\(h)\(o)\(f))"

    case let .raise(exc, cause):
      let e = exc.map { " " + describe($0) } ?? ""
      let c = cause.map { " from: " + describe($0) } ?? ""
      return "(raise\(e)\(c))"

    case let .import(names):
      return "(import \(join(names)))"
    case let .importFrom(module, names, level):
      let d = level == 0 ? "" : String(repeating: ".", count: Int(level))
      let m = module.map(describe) ?? ""
      return "(from \(d)\(m) import: \(join(names)))"
    case let .importFromStar(module, level):
      let d = level == 0 ? "" : String(repeating: ".", count: Int(level))
      let m = module.map(describe) ?? ""
      return "(from \(d)\(m) import: *)"

    case let .global(v):
      return "(global \(join(v)))"
    case let .nonlocal(v):
      return "(nonlocal \(join(v)))"

    case let .assert(test, msg):
      let m = msg.map { " msg: " + describe($0) } ?? ""
      return "(assert \(test)\(m))"

    case let .expr(e):
      return describe(e)

    case .pass:
      return "(pass)"
    case .break:
      return "(break)"
    case .continue:
      return "(continue)"
    }
  }
}

extension Alias: CustomStringConvertible {
  public var description: String {
    switch self.asName {
    case .none:
      return name
    case let .some(alias):
      return "(\(name) as: \(alias))"
    }
  }
}

extension WithItem: CustomStringConvertible {
  public var description: String {
    switch self.optionalVars {
    case .none:
      return describe(self.contextExpr)
    case .some(let opt):
      return "(\(self.contextExpr) as: \(opt))"
    }
  }
}

extension ExceptHandler: CustomStringConvertible {
  public var description: String {
    let b = self.body.isEmpty ? "" : " do: \(join(self.body))"

    switch self.kind {
    case let .typed(type: type, asName: asName):
      let n = asName.map { " as: \($0)" } ?? ""
      return "(except \(describe(type))\(n)\(b))"
    case .default:
      return "(except\(b))"
    }
  }
}

// MARK: - Expression

extension Expression: CustomStringConvertible, CustomDebugStringConvertible {
  public var description: String {
    return describe(self.kind)
  }

  public var debugDescription: String {
    return "Expression(\(self.kind), start: \(self.start), end: \(self.end))"
  }
}

extension ExpressionKind: CustomStringConvertible {
  public var description: String {
    switch self {

    case .true:  return "True"
    case .false: return "False"
    case .none:  return "None"
    case .ellipsis: return "..."

    case let .identifier(value): return describe(value)
    case let .int(value):        return describe(value)
    case let .float(value):      return describe(value)

    case let .complex(real: real, imag: imag):
      return "(\(real)+\(imag)j)"

    case let .string(s):
      return describe(s)
    case let .bytes(data):
      return "(bytes count:\(data.count))"

    case let .unaryOp(op, right: right):
      return "(\(op) \(right))"
    case let .binaryOp(op, left: left, right: right):
      return "(\(op) \(left) \(right))"
    case let .boolOp(op, left: left, right: right):
      return "(\(op) \(left) \(right))"
    case let .compare(left: left, elements: elements):
      return "(\(left) \(join(elements)))"

    case let .tuple(value):
      return "(" + join(value) + ")"
    case let .list(value):
      return "[" + join(value) + "]"
    case let .dictionary(value):
      return "{" + join(value) + "}"
    case let .set(value):
      return "{" + join(value) + "}"

    case let .listComprehension(elt, generators):
      return "(listCompr \(elt) \(join(generators)))"
    case let .setComprehension(elt, generators):
      return "(setCompr \(elt) \(join(generators)))"
    case let .dictionaryComprehension(key, value, generators):
      return "(dicCompr \(key):\(value) \(join(generators)))"
    case let .generatorExp(elt, generators):
      return "(generatorCompr \(elt) \(join(generators)))"

    case let .await(value):
      return "(await \(value))"
    case let .yield(value):
      let s = value.map { " " + describe($0) } ?? ""
      return "(yield\(s))"
    case let .yieldFrom(value):
      return "(yieldFrom \(value))"

    case let .lambda(args: args, body: body):
      return "(λ \(args) do: \(body))"

    case let .call(name, args, keywords):
      // This may reorder arguments! Positional before keyword ones.
      var ak = ""
      switch (args.isEmpty, keywords.isEmpty) {
      case (true, true): break
      case (false, true):  ak = join(args)
      case (true, false):  ak = join(keywords)
      case (false, false): ak = join(args) + " " + join(keywords)
      }

      return "\(name)(\(ak))"

    case let .ifExpression(test: test, body: body, orElse: orElse):
      return "(if \(test)) then \(body)) else \(orElse))"

    case let .starred(value):
      return "*\(value)"
    case let .attribute(value, name):
      return "\(value).\(name)"
    case let .subscript(value, slice):
      return "\(value)[\(slice)]"
    }
  }
}

// MARK: - Opertors

extension UnaryOperator: CustomStringConvertible {
  public var description: String {
    switch self {
    case .invert: return "inv"
    case .not:    return "not"
    case .plus:  return "+"
    case .minus: return "-"
    }
  }
}

extension BooleanOperator: CustomStringConvertible {
  public var description: String {
    switch self {
    case .and: return "and"
    case .or:  return "or"
    }
  }
}

extension BinaryOperator: CustomStringConvertible {
  public var description: String {
    switch self {
    case .add: return "+"
    case .sub: return "-"
    case .mul: return "*"
    case .matMul: return "@"
    case .div: return "/"
    case .modulo: return "%"
    case .pow: return "**"
    case .leftShift: return "<<"
    case .rightShift: return ">>"
    case .bitOr: return "|"
    case .bitXor: return "^"
    case .bitAnd: return "&"
    case .floorDiv: return "//"
    }
  }
}

extension ComparisonElement: CustomStringConvertible {
  public var description: String {
    return "\(self.op) \(self.right)"
  }
}

extension ComparisonOperator: CustomStringConvertible {
  public var description: String {
    switch self {
    case .equal:    return "="
    case .notEqual: return "!="
    case .less:      return "<"
    case .lessEqual: return "<="
    case .greater:      return ">"
    case .greaterEqual: return ">="
    case .is:    return "is"
    case .isNot: return "is not"
    case .in:    return "in"
    case .notIn: return "not in"
    }
  }
}

// MARK: - String

extension StringGroup: CustomStringConvertible {
  public var description: String {
    switch self {
    case let .literal(s):
      return "'" + prefix(s, length: 20) + "'"
    case let .formattedValue(v, conversion: conversion, spec: spec):
      let c = conversion.map { " " + describe($0) } ?? ""
      let s = spec.map { " " + describe($0) } ?? ""
      return "f'\(v)\(c)\(s)'"
    case let .joined(groups):
      return "(\(join(groups)))"
    }
  }
}

extension ConversionFlag: CustomStringConvertible {
  public var description: String {
    switch self {
    case .str:   return "str"
    case .ascii: return "ascii"
    case .repr:  return "repr"
    }
  }
}

// MARK: - Slice

extension Slice: CustomStringConvertible, CustomDebugStringConvertible {
  public var description: String {
    return describe(self.kind)
  }

  public var debugDescription: String {
    return "Slice(\(self.kind), start: \(self.start), end: \(self.end))"
  }
}

extension SliceKind: CustomStringConvertible {
  public var description: String {
    switch self {
    case let .index(index):
      return describe(index)
    case let .extSlice(dims: dims):
      return "(" + join(dims) + ")"
    case let .slice(lower: lower, upper: upper, step: step):
      let l = lower.map(describe) ?? ""
      let u = upper.map(describe) ?? ""
      let s = step.map(describe) ?? ""
      return "\(l):\(u):\(s)"
    }
  }
}

// MARK: - Comprehension

extension Comprehension: CustomStringConvertible {
  public var description: String {
    var ifs = ""
    switch self.ifs.count {
    case 0: break
    case 1: ifs = " if " + describe(self.ifs[0])
    default: ifs = " (if " + join(self.ifs) + ")"
    }

    let async = self.isAsync ? "async " : ""
    return "(\(async)for \(self.target) in \(self.iter)\(ifs))"
  }
}

// MARK: - Dictionary

extension DictionaryElement: CustomStringConvertible {
  public var description: String {
    switch self {
    case let .unpacking(expr):
      return "**" + describe(expr)
    case let .keyValue(key: key, value: value):
      return describe(key) + ":" + describe(value)
    }
  }
}

// MARK: - Arguments

extension Arguments: CustomStringConvertible, CustomDebugStringConvertible {

  /// (a *b c=None **d)
  public var description: String {
    var result = ""

    result += self.describeArguments(args: self.args, defaults: self.defaults)

    switch self.vararg {
    case .none: break
    case .unnamed: result += "* "
    case .named(let arg): result += "*" + describe(arg) + " "
    }

    result += self.describeArguments(args: self.kwOnlyArgs, defaults: self.kwOnlyDefaults)

    switch self.kwarg {
    case .none: break
    case .some(let arg): result += "**" + describe(arg)
    }

    if result.last == " " {
      result = String(result.dropLast())
    }

    return "(" + result + ")"
  }

  public var debugDescription: String {
    let k = self.kwarg.map { describe($0) } ?? "[]"

    var result = ""
    result += "args: \(self.args), "
    result += "defaults: \(self.defaults), "
    result += "vararg: \(self.vararg), "
    result += "kwOnlyArgs: \(self.kwOnlyArgs), "
    result += "kwOnlyDefaults: \(self.kwOnlyDefaults), "
    result += "kwarg: \(k), "
    result += "start: \(self.start), "
    result += "end: \(self.end))"

    return "Arguments(\(result))"
  }

  private func describeArguments(args: [Arg],
                                 defaults: [Expression]) -> String {
    assert(defaults.count <= args.count)

    if args.isEmpty {
      return ""
    }

    let defaultsStart = args.count - defaults.count

    // args: (a (b=1) (c:Int) (c:Int=1))
    var result = [String]()
    for (index, arg) in args.enumerated() {
      let defaultIndex = index - defaultsStart
      let defaultValue = defaultIndex < 0 ? nil : defaults[defaultIndex]

      switch (arg.annotation, defaultValue) {
      case (.none, .none): // a
        result.append(arg.name)
      case let (.some(ann), .none): // a:Int
        result.append("\(arg.name):\(describe(ann))")
      case let (.none, .some(def)): // a=5
        result.append("\(arg.name)=\(describe(def))")
      case let (.some(ann), .some(def)): // a:Int=1
        result.append("\(arg.name):\(describe(ann)) = \(describe(def))")
      }
    }
    return join(result) + " "
  }
}

extension Arg: CustomStringConvertible, CustomDebugStringConvertible {
  public var description: String {
    switch self.annotation {
    case .none: return self.name
    case .some(let ann): return "(\(self.name):\(ann))"
    }
  }

  public var debugDescription: String {
    var result = ""
    result += "name: \(self.name), "
    result += self.annotation.map { "annotation: \($0), " } ?? ""
    result += "start: \(self.start), "
    result += "end: \(self.end)"
    return "Arg(\(result)"
  }
}

extension Vararg: CustomStringConvertible {
  public var description: String {
    switch self {
    case .none:    return "none"
    case .unnamed: return "unnamed"
    case .named(let value): return "named(\(value))"
    }
  }
}

extension Keyword: CustomStringConvertible {
  public var description: String {
    switch self.name {
    case .none:
      return "**" + describe(self.value)
    case .some(let name):
      return "\(name)=\(self.value)"
    }
  }
}
