import Core
import Parser
import Bytecode

public enum CodeObjectType {
  case module
  case `class`
  case function
  case asyncFunction
  case lambda
  case comprehension
}

public final class CodeObject {

  /// Name of the class if the code is for a class.
  /// Name of the function if the code is for a function.
  /// Otherwise 'top'.
  public let name: String
  /// Type of the code object.
  /// Possible values are: module, class, (async)function, lambda and comprehension.
  public let type: CodeObjectType
  /// First source line number
  public let firstLine: SourceLine

  /// Instruction opcodes.
  public var instructions = [Instruction]()
  /// Instruction locations.
  public var instructionLines = [SourceLine]()
  // TODO: ^ Use struct InstructionLocation = (index, line) - Objects/lnotab_notes

  /// Constants used.
  /// E.g. `LoadConst 5` loads `self.constants[5]` value.
  public var constants = [Constant]()
  /// List of strings (names used).
  /// E.g. `LoadName 5` loads `self.names[5]` value.
  public var names = [String]()
  /// Absolute jump targets.
  /// E.g. label `5` will move us to instruction at `self.labels[5]` index.
  public var labels = [Int]()

  // TODO: This is filled in 'visitFunction'
  /// Arguments, except *args
//  public var argCount = 0
  /// Keyword only arguments
//  public var kwOnlyArgCount = 0

  // TODO: This is filled in 'enter scope'
  /// List of strings (local variable names)
//  public var varNames = [String]()
  /// List of strings (free variable names)
//  public var freeVars = [String]()
  /// List of strings (cell variable names)
//  public var cellVars = [String]()

  public init(name: String, type: CodeObjectType, line: SourceLine) {
    self.name = name
    self.type = type
    self.firstLine = line
  }
}
