import Core

public enum CodeObjectType {
  case module
  case `class`
  case function
  case asyncFunction
  case lambda
  case comprehension
}

// TODO: To struct
public final class CodeObject {

  /// Name of the class if the code is for a class.
  /// Name of the function if the code is for a function.
  /// Otherwise 'top'.
  public let name: String
  /// Dot-separated qualified name.
  ///
  /// For example:
  /// ```c
  /// class frozen: <- qualified name: frozen
  ///   def elsa:   <- qualified name: frozen.elsa
  ///     pass
  /// ```
  public let qualifiedName: String

  /// Type of the code object.
  /// Possible values are: module, class, (async)function, lambda and comprehension.
  public let type: CodeObjectType
  /// First source line number
  public let firstLine: SourceLine

  /// Instruction opcodes.
  public internal(set) var instructions = [Instruction]()
  /// Instruction locations.
  public internal(set) var instructionLines = [SourceLine]()
  // TODO: ^ Use struct InstructionLocation = (index, line) - Objects/lnotab_notes

  /// Constants used.
  /// E.g. `LoadConst 5` loads `self.constants[5]` value.
  public internal(set) var constants = [Constant]()
  /// List of strings (names used).
  /// E.g. `LoadName 5` loads `self.names[5]` value.
  public internal(set) var names = [String]()
  /// Absolute jump targets.
  /// E.g. label `5` will move us to instruction at `self.labels[5]` index.
  public internal(set) var labels = [Int]()

  /// List of local variable names
  public var varNames = [MangledName]()
  /// List of free variable names
  public var freeVars = [MangledName]()
  /// List of cell variable names
  public var cellVars = [MangledName]()

  public init(name: String,
              qualifiedName: String,
              type: CodeObjectType,
              varNames: [MangledName],
              freeVars: [MangledName],
              cellVars: [MangledName],
              line: SourceLine) {
    self.name = name
    self.qualifiedName = qualifiedName
    self.type = type
    self.firstLine = line
  }
}
