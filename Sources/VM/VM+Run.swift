import Core
import Objects
import Foundation

// In CPython:
// Python -> main.c

// swiftlint:disable file_length

extension VM {

  // MARK: - Run

  /// static void
  /// pymain_run_python(_PyMain *pymain)
  ///
  /// This method was not intended to be called multiple times,
  /// but it is not like we can stop you.
  ///
  /// CPython (somewhere around):
  /// static int
  /// pymain_cmdline_impl(_PyMain *pymain, _PyCoreConfig *config, ...)
  public func run() -> PyBaseException? {
    if self.arguments.help {
      print(Objects.Arguments.helpMessage)
      return nil
    }

    if self.arguments.version {
      print(Py.sys.version)
      return nil
    }

    // Oh no... we will be running code! Let's prepare for this.
    // For some reason importing stuff seems to be important* in programming...
    // * Pun intended (sorry!)
    if let e = self.initImportlibIfNeeded() {
      return e
    }

    var runRepl = false
    var result: PyResult<PyObject>

    if let command = self.arguments.command {
      result = self.run(command: command)
    } else if let module = self.arguments.module {
      result = self.run(modulePath: module)
    } else if let script = self.arguments.script {
      result = self.run(scriptPath: script)
    } else {
      runRepl = true
      result = self.prepareForInteractiveWithoutArgs()
    }

    switch result {
    case .value:
      break // Let's ignore the returned value
    case .error(let e) where e.isSystemExit:
      return nil // Everything is fine
    case .error(let e):
      return e
    }

    if runRepl || Py.sys.flags.inspect {
      self.runRepl()
    }

    return nil
  }

  private func initImportlibIfNeeded() -> PyBaseException? {
    // This is probably the first time you see our error handling approach.
    // So... we are using 'enums' instead of Swift 'throw'.
    // There is a long comment about this in 'README' for 'Objects' module.

    // Also, both 'initImportlibIfNeeded' and 'initImportlibExternalIfNeeded'
    // are idempotent, so we can call them as many times as we want.
    // Unless you do something like 'sys.modules['importlib'] = "let it go"',
    // in such case we will reinitialize the whole thing.

    let importlib: PyModule
    switch Py.initImportlibIfNeeded() {
    case let .value(m): importlib = m
    case let .error(e): return e
    }

    switch Py.initImportlibExternalIfNeeded(importlib: importlib) {
    case .value: break
    case .error(let e): return e
    }

    return nil
  }

  // MARK: - Run command

  private func run(command: String) -> PyResult<PyObject> {
    // From: https://docs.python.org/3.7/using/cmdline.html#cmdoption-c
    // Execute the Python code in 'command'.
    // 'command' can be one or more statements separated by newlines
    // - 1st element of sys.argv will be "-c"
    // - current directory will be added to the start of sys.path
    //   (allowing modules in that directory to be imported as top level modules).
    self.unimplemented()
  }

  // MARK: - Run module

  private func run(modulePath: String) -> PyResult<PyObject> {
    // From: https://docs.python.org/3.7/using/cmdline.html#cmdoption-m
    // Search sys.path for the named module and execute its contents
    // as the __main__ module.
    // - 1st element of sys.argv will be the full path to the module file
    //   (while the module file is being located, it will be set to "-m")
    // - As with the -c option, the current directory will be added
    //   to the start of sys.path.
    self.unimplemented()
  }

  // MARK: - Run script

  /// static void
  /// pymain_run_filename(_PyMain *pymain, PyCompilerFlags *cf)
  private func run(scriptPath: String) -> PyResult<PyObject> {
    // From 'https://docs.python.org/3.7/using/cmdline.html':
    // Execute the Python code contained in script, which must be a filesystem path
    // (absolute or relative) referring to either a Python file, a directory
    // containing a __main__.py file, or a zipfile containing a __main__.py file.
    // - 1st element of sys.argv will be the script name as given on the command line
    // - If the script name refers to a Python file,
    //   the directory containing that file is added to the start of sys.path,
    //   and the file is executed as the __main__ module.
    // - If the script name refers to a directory or zipfile,
    //   the script name is added to the start of sys.path and
    //   the __main__.py file in that location is executed as the __main__ module.
    // Btw. we don't support 'PYTHONSTARTUP'!

    let script: ScriptLocation
    switch self.getScriptLocation(path: scriptPath) {
    case let .value(s): script = s
    case let .error(e): return .error(e)
    }

    let code: PyCode
    switch Py.compile(url: script.__main__, mode: .fileInput) {
    case let .value(c): code = c
    case let .error(e): return .error(e)
    }

    if let e = self.setArgv0(value: scriptPath) {
      return .error(e)
    }

    if let e = self.prependPath(value: script.directory.path) {
      return .error(e)
    }

    let main: PyModule
    switch self.add__main__Module() {
    case let .value(m): main = m
    case let .error(e): return .error(e)
    }

    let mainDict = main.getDict()
    mainDict.set(id: .__file__, to: Py.newString(scriptPath))

    // Whatever happens we need to do cleanup:
    defer { _ = mainDict.del(id: .__file__) }

    return self.eval(code: code, globals: mainDict, locals: mainDict)
  }

  private struct ScriptLocation {
    /// File to execute.
    fileprivate let __main__: URL
    /// Directory to add to `sys.path`.
    fileprivate let directory: URL
  }

  private func getScriptLocation(path: String) -> PyResult<ScriptLocation> {
    let stat: FileStat

    switch self.fileSystem.stat(path: path) {
    case .value(let s):
      stat = s
    case .enoent:
      return .error(Py.newFileNotFoundError())
    case .error(let e):
      return .error(e)
    }

    // If it is 'regular file' then return it,
    // otherwise try '__main_._py' inside this dir.

    if stat.isRegularFile {
      let main = URL(fileURLWithPath: path, isDirectory: false)
      let dir = main.deletingLastPathComponent()
      return .value(ScriptLocation(__main__: main, directory: dir))
    }

    guard stat.isDirectory else {
      let msg = "'\(path)' is neither file nor directory (mode: \(stat.st_mode))"
      return .error(Py.newOSError(msg: msg))
    }

    let dir = URL(fileURLWithPath: path, isDirectory: true)
    let main = dir.appendingPathComponent("__main__.py")

    switch self.fileSystem.stat(path: main.path) {
    case .value(let s):
      if s.isRegularFile {
        return .value(ScriptLocation(__main__: main, directory: dir))
      }

      let msg = "'\(main.path)' is not a file (mode: \(s.st_mode))"
      return .error(Py.newOSError(msg: msg))

    case .enoent:
      return .error(Py.newFileNotFoundError())
    case .error(let e):
      return .error(e)
    }
  }

  // MARK: - No args

  private func prepareForInteractiveWithoutArgs() -> PyResult<PyObject> {
    // From 'https://docs.python.org/3.7/using/cmdline.html'
    // If no interface option is given:
    // - -i is implied
    // - sys.argv[0] is an empty string ("")
    // - current directory will be added to the start of sys.path.

    if let e = self.setArgv0(value: "") {
      return .error(e)
    }

    let cwd = self.fileSystem.currentWorkingDirectory
    if let e = self.prependPath(value: cwd) {
      return .error(e)
    }

    return .value(Py.none)
  }

  // MARK: - Run REPL

  private func runRepl() {
//    var input = ""
//    var isContinuing = false
//
//    while true {
//      let prompt = isContinuing ? self.sys.ps2String : self.sys.ps1String
//      print(prompt, terminator: "")
//
//      switch readLine() {
//      case let .some(line):
//        let stopContinuing = line.isEmpty
//
//        if input.isEmpty {
//          input = line
//        } else {
//          input.append(line)
//        }
//        input.append("\n")
//
//        if isContinuing {
//          if stopContinuing {
//            isContinuing = false
//          } else {
//            continue
//          }
//        }
//
//        switch self.runInteractive(input: input) {
//        case .ok:
//          input = ""
//        case .notFinished:
//          isContinuing = true
//        case let .error(e):
//          throw e
//        }
//
//      case .none:
//        return
//      }
//    }
    self.unimplemented()
  }

//  private enum RunInteractiveResult {
//    case ok
//    case notFinished
//    case error(Error)
//  }
//
//  private func runInteractive(input: String) -> RunInteractiveResult {
//    do {
//      let code = try self.compile(filename: "<stdin>", source: input, mode: .interactive)
//
//      let module = self.builtins.newModule(name: "__main__")
//      let moduleDict = self.builtins.getDict(module)
//
//      self.run(code: code, globals: moduleDict, locals: moduleDict)
//      return .ok
//    } catch let error as LexerError {
//      switch error.kind {
//      case .eof, .unfinishedLongString: return .notFinished
//      default: return .error(error)
//      }
//    } catch let error as ParserError {
//      switch error.kind {
//      case .unexpectedEOF: return .notFinished
//      default: return .error(error)
//      }
//    } catch {
//      return .error(error)
//    }
//  }

  // MARK: - Helpers

  /// Set given value as `sys.argv[0]`.
  private func setArgv0(value: String) -> PyBaseException? {
    switch Py.sys.setArgv0(value: value) {
    case .value:
      return nil
    case .error(let e):
      return e
    }
  }

  /// Prepend given value to `sys.path`.
  private func prependPath(value: String) -> PyBaseException? {
    switch Py.sys.prependPath(value: value) {
    case .value:
      return nil
    case .error(let e):
      return e
    }
  }

  private func add__main__Module() -> PyResult<PyModule> {
    let name = Py.getInterned("__main__")
    let module = Py.newModule(name: name)

    switch Py.sys.addModule(name: name, module: module) {
    case .value:
      return .value(module)
    case .error(let e):
      return .error(e)
    }
  }
}
