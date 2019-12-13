import Foundation

// MARK: - Config

public struct PyContextConfig {
  // Default hash key is 'VioletEvergarden' in ASCII
  public var hashKey0: UInt64 = 0x56696f6c65744576
  public var hashKey1: UInt64 = 0x657267617264656e

  public var stdout: StandardOutput = FileHandle.standardOutput

  public init() { }
}

// MARK: - Context

public class PyContext {

  internal let stdout: StandardOutput
  internal let hasher: Hasher

  public private(set) lazy var builtins = Builtins(context: self)

  public init(config: PyContextConfig) {
    self.stdout = config.stdout
    self.hasher = Hasher(key0: config.hashKey0, key1: config.hashKey1)

    // This is hack, but we can access `self.builtins` here because they are
    // annotated as `lazy` (even though they need `PyContext` in ctor).
    self.builtins.onContextFullyInitailized()
  }

  deinit {
    self.builtins.onContextDeinit()
  }
}
