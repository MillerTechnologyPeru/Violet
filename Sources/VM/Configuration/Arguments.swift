import ArgumentParser
import Core
import Compiler

// In CPython:
// Modules -> main.c
//  pymain_wstrlist_append(_PyMain *pymain, int *len, wchar_t ***list, ...)

// Descriptions taken from:
// https://docs.python.org/3.7/using/cmdline.html

public struct Arguments {

  // MARK: - Flags

  /// `-h -help --help`
  ///
  /// Display available options.
  public var help = false

  /// `-v --version`
  ///
  /// Print the `Violet` version number and exit.
  /// Example output could be: `Violet 1.0`.
  public var version = false

  /// `-d`
  ///
  ///  Turn on debugging output.
  public var debug = false

  /// `-q`
  ///
  ///  Don’t display the copyright and version messages even in interactive mode.
  public var quiet = false

  /// `-i`
  ///
  /// When a script is passed as first argument or the `-c` option is used,
  /// enter interactive mode after executing the script or the command,
  /// even when `sys.stdin` does not appear to be a terminal.
  public var inspectInteractively = false

  /// `-E`
  ///
  /// Ignore all `PYTHON*` environment variables,
  /// e.g. `PYTHONPATH` and `PYTHONHOME`, that might be set.
  public var ignoreEnvironment = false

  /// `-I`
  ///
  /// Run Python in isolated mode. This also implies `-E` and `-s`.
  /// In isolated mode `sys.path` contains neither the script’s directory
  /// nor the user’s site-packages directory.
  /// All `PYTHON*` environment variables are ignored, too.
  public var isolated = false

  /// `-S`
  ///
  /// Disable the import of the module site and the site-dependent manipulations
  /// of `sys.path` that it entails.
  /// Also disable these manipulations if site is explicitly imported later
  /// (call `site.main()` if you want them to be triggered).
  public var noSite = false

  /// `-s`
  ///
  /// Don’t add the user site-packages directory to `sys.path`.
  /// See also 'PEP 370 – Per user site-packages directory'.
  public var noUserSite = false

  // MARK: - Optimization

  /// `-O -OO`
  public var optimization = OptimizationLevel.none

  // MARK: - Warnings

  /// `-Werror -Wignore etc.`
  ///
  /// Warning control.
  /// By default prints warning messages to `sys.stderr`.
  public var warnings = [WarningOption]()

  // MARK: - Bytes warning

  /// `-b -bb`
  ///
  /// Issue a warning when comparing `bytes` or `bytearray` with `str`
  /// or bytes with int.
  /// Issue an error when the option is given twice (`-bb`).
  public var bytesWarning = BytesWarningOption.ignore

  // MARK: Command, module, script

  /// `-c <command>`
  ///
  /// Execute the Python code in `command`.
  /// `command` can be one or more statements separated by newlines,
  /// with significant leading whitespace as in normal module code.
  ///
  /// We need to add '\n' just as in
  /// pymain_parse_cmdline_impl(_PyMain *pymain, _PyCoreConfig *config, ...)
  public var command: String?

  /// `-m <module-name>`
  ///
  /// Search sys.path for the named module and execute its contents
  /// as the `__main__` module.
  public var module: String?

  /// `<script>`
  ///
  /// Execute the Python code contained in `script`,
  /// which must be a filesystem path (absolute or relative)
  /// referring to either a Python file,
  /// or a directory containing a `__main__.py` file.
  public var script: String?

  /// Arguments just as entered in command line (used for `sys.argv`).
  public var raw: [String] = []

  // MARK: - Init

  /// Use arguments with default values.
  public init() { }

  /// Parse specified command line arguments.
  public init(from arguments: [String]) throws {
    self.raw = arguments

    let argumentsWithoutProgramName = Array(arguments.dropFirst())
    let binding = try ArgumentBinding.parse(argumentsWithoutProgramName)

    // This is quite a repetition!
    // But arguments tend not to be changed a lot.
    self.help = binding.help
    self.version = binding.version
    self.debug = binding.debug
    self.quiet = binding.quiet
    self.inspectInteractively = binding.inspectInteractively
    self.ignoreEnvironment = binding.ignoreEnvironment
    self.isolated = binding.isolated
    self.noSite = binding.noSite
    self.noUserSite = binding.noUserSite

    // Isolated implies some other flags set to 'true'
    if self.isolated {
      self.ignoreEnvironment = true
      self.noUserSite = true
    }

    self.optimization = self.getOptimization(binding: binding)
    self.bytesWarning = self.getBytesWarning(binding: binding)

    self.appendWarning(flag: binding.wDefault, warning: .default)
    self.appendWarning(flag: binding.wError, warning: .error)
    self.appendWarning(flag: binding.wAlways, warning: .always)
    self.appendWarning(flag: binding.wModule, warning: .module)
    self.appendWarning(flag: binding.wOnce, warning: .once)
    self.appendWarning(flag: binding.wIgnore, warning: .ignore)

    // 'Command' should end with '\n'
    self.command = binding.command.map { $0 + "\n" }
    self.module = binding.module
    self.script = binding.script
  }

  private mutating func appendWarning(flag: Bool, warning: WarningOption) {
    if flag {
      self.warnings.append(warning)
    }
   }

  private func getOptimization(binding: ArgumentBinding) -> OptimizationLevel {
    if binding.optimization2 {
      return .OO
    }

    if binding.optimization1 {
      return .O
    }

    return .none
  }

  private func getBytesWarning(binding: ArgumentBinding) -> BytesWarningOption {
    switch binding.bytesWarning {
    case 0: return .ignore
    case 1: return .warning
    default: return .error
    }
  }

  // MARK: - Usage

  internal var usage: String {
    do {
      let binding = ArgumentBinding()
      _ = try binding.run()

      let msg = "By default 'apple/swift-argument-parser' should " +
        "throw 'CleanExit.helpRequest' if we don't override 'run()' " +
        "but somehow that did not happen."

      trap(msg)
    } catch {
      assert(self.isCleanExit_HelpRequest(error: error))

      var result = ArgumentBinding.fullMessage(for: error)

      // 'ArgumentParser' has tendency to add ' ' before new line.
      // (Which is ugly and messes unit tests for people who have
      // automatic whitespace trimming turned on.)
      result = result.replacingOccurrences(of: " \n", with: "\n")

      // 'ArgumentParser' adds new line at the end. (Again, kind of ugly.)
      result = result.trimmingCharacters(in: .newlines)
      return result
    }
  }

  private func isCleanExit_HelpRequest(error: Error) -> Bool {
    if case CleanExit.helpRequest = error {
      return true
    }

    return false
  }
}
