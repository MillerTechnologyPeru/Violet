// https://docs.python.org/3/reference/lexical_analysis.html#integer-literals
// There is no limit for the length of integer literals apart
// from what can be stored in available memory.

public struct PyInt: Equatable, Hashable {

  // Range: <-Int64.max, Int64.max> due to '-' being unary operator.
  public static let min = PyInt(-Int64.max)
  public static let max = PyInt(Int64.max)

  private let value: Int64

  public init(_ value: Int64) {
    self.value = value
  }

  public init(_ value: Int) {
    self.value = Int64(value)
  }

  /// This should be used only by the lexer!
  public init?<S>(_ text: S, radix: Int = 10) where S : StringProtocol {
    guard let value = Int64(text, radix: radix) else {
      return nil
    }
    self.value = value
  }
}

extension PyInt: CustomStringConvertible {
  public var description: String {
    return String(describing: self.value)
  }
}
