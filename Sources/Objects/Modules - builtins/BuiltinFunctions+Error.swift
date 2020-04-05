import Core
import Lexer
import Parser
import Compiler
import Foundation

// In CPython:
// Objects -> exceptions.c
// Python -> errors.c
// https://docs.python.org/3.7/library/exceptions.html

// swiftlint:disable file_length

extension BuiltinFunctions {

  // MARK: - Type error

  /// Inappropriate argument type.
  public func newTypeError(msg: String) -> PyTypeError {
    return PyTypeError(msg: msg)
  }

  // MARK: - Value error

  /// Inappropriate argument value (of correct type).
  public func newValueError(msg: String) -> PyValueError {
    return PyValueError(msg: msg)
  }

  // MARK: - Index error

  /// Sequence index out of range.
  public func newIndexError(msg: String) -> PyIndexError {
    return PyIndexError(msg: msg)
  }

  // MARK: - Attribute error

  /// Attribute not found.
  public func newAttributeError(msg: String) -> PyAttributeError {
    return PyAttributeError(msg: msg)
  }

  /// Attribute not found.
  public func newAttributeError(
    object: PyObject,
    hasNoAttribute name: String
  ) -> PyAttributeError {
    let msg = "\(object.typeName) object has no attribute '\(name)'"
    return self.newAttributeError(msg: msg)
  }

  /// Attribute is read-only.
  public func newAttributeError(
    object: PyObject,
    attributeIsReadOnly name: String
  ) -> PyAttributeError {
    let msg = "'\(object.typeName)' object attribute '\(name)' is read-only"
    return self.newAttributeError(msg: msg)
  }

  // MARK: - Numeric errors

  /// Second argument to a division or modulo operation was zero.
  public func newZeroDivisionError(msg: String) -> PyZeroDivisionError {
    return PyZeroDivisionError(msg: msg)
  }

  /// Result too large to be represented.
  public func newOverflowError(msg: String) -> PyOverflowError {
    return PyOverflowError(msg: msg)
  }

  // MARK: - System error

  /// Internal error in the Python interpreter.
  public func newSystemError(msg: String) -> PySystemError {
    return PySystemError(msg: msg)
  }
  // MARK: - Runtime error

  /// Unspecified run-time error.
  public func newRuntimeError(msg: String) -> PyRuntimeError {
    return PyRuntimeError(msg: msg)
  }

  // MARK: - OS error

  /// Base class for I/O related errors.
  ///
  /// https://docs.python.org/3/library/exceptions.html#OSError
  public func newOSError(msg: String) -> PyOSError {
    return PyOSError(msg: msg)
  }

  public func newOSError(errno: Int32) -> PyOSError {
    let args = self.createOSErrorArgs(errno: errno, filename: nil)
    let tuple = Py.newTuple(args)
    return PyOSError(args: tuple)
  }

  /// Base class for I/O related errors.
  public func newOSError(errno: Int32, filename: String) -> PyOSError {
    let args = self.createOSErrorArgs(errno: errno, filename: filename)
    let tuple = Py.newTuple(args)
    return PyOSError(args: tuple)
  }

  /// Base class for I/O related errors.
  public func newOSError(errno: Int32, path: String) -> PyOSError {
    // If we can't get filename then we will use full path.
    // It is still better than not providing anything.
    let filename = self.getFilename(path: path) ?? path
    return self.newOSError(errno: errno, filename: filename)
  }

  /// https://docs.python.org/3/library/exceptions.html#OSError
  private func createOSErrorArgs(errno: Int32, filename: String?) -> [PyObject] {
    var result = [PyObject]()
    result.append(Py.newInt(errno))

    let str = String(errno: errno) ?? "unknown OS error (errno: \(errno))"
    result.append(Py.newString(str))

    if let filename = filename {
      result.append(Py.newString(filename))
    }

    return result
  }

  /// If this string represents file path then try to obtain
  /// name of the file/directory.
  private func getFilename(path: String) -> String? {
    let url = URL(fileURLWithPath: path)
    let filename = url.lastPathComponent
    return filename.isEmpty ? nil : filename
  }

  // MARK: - File not found

  public func newFileNotFoundError() -> PyFileNotFoundError {
    let result = PyFileNotFoundError(msg: "No such file or directory")
    return result
  }

  // MARK: - Key error

  /// Mapping key not found.
  public func newKeyError(msg: String) -> PyKeyError {
    return PyKeyError(msg: msg)
  }

  /// Mapping key not found.
  public func newKeyError(key: PyObject) -> PyKeyError {
    let args = self.newTuple(key)
    return PyKeyError(args: args)
  }

  // MARK: - Lookup error

  /// Base class for lookup errors.
  public func newLookupError(msg: String) -> PyLookupError {
    return PyLookupError(msg: msg)
  }

  // MARK: - Stop iteration

  /// Signal the end from iterator.__next__().
  public func newStopIteration(value: PyObject? = nil) -> PyStopIteration {
    let args = self.newTuple(value ?? Py.none)
    return PyStopIteration(args: args)
  }

  // MARK: - Name errors

  /// Name not found globally.
  public func newNameError(msg: String) -> PyNameError {
    return PyNameError(msg: msg)
  }

  /// Local name referenced but not bound to a value.
  public func newUnboundLocalError(variableName: String) -> PyUnboundLocalError {
    let msg = "local variable '\(variableName)' referenced before assignment"
    return PyUnboundLocalError(msg: msg)
  }

  // MARK: - Unicode encoding

  /// Unicode decoding error.
  public func newUnicodeDecodeError(
    data: Data,
    encoding: PyStringEncoding
  ) -> PyUnicodeDecodeError {
    let bytes = Py.newBytes(data)
    return self.newUnicodeDecodeError(data: bytes, encoding: encoding)
  }

  /// Unicode decoding error.
  internal func newUnicodeDecodeError(
    data: PyBytesType,
    encoding: PyStringEncoding
  ) -> PyUnicodeDecodeError {
    let msg = "'\(encoding)' codec can't decode data"
    let error = PyUnicodeDecodeError(msg: msg)

    let dict = error.__dict__
    dict.set(id: .object, to: data)
    dict.set(id: .encoding, to: Py.newString(encoding))

    return error
  }

  /// Unicode encoding error.
  public func newUnicodeEncodeError(
    string: String,
    encoding: PyStringEncoding
  ) -> PyUnicodeEncodeError {
    let str = Py.newString(string)
    return self.newUnicodeEncodeError(string: str, encoding: encoding)
  }

  /// Unicode encoding error.
  public func newUnicodeEncodeError(
    string: PyString,
    encoding: PyStringEncoding
  ) -> PyUnicodeEncodeError {
    let msg = "'\(encoding)' codec can't encode data"
    let error = PyUnicodeEncodeError(msg: msg)

    let dict = error.__dict__
    dict.set(id: .object, to: string)
    dict.set(id: .encoding, to: Py.newString(encoding))

    return error
  }

  // MARK: - Assertion error

  /// Assertion failed.
  public func newAssertionError(msg: String) -> PyAssertionError {
    return PyAssertionError(msg: msg)
  }

  // MARK: - Import error

  /// Import failed.
  public func newPyImportError(msg: String) -> PyImportError {
    return PyImportError(msg: msg)
  }

  // MARK: - Syntax error

  public func newSyntaxError(filename: String,
                             error: LexerError) -> PySyntaxError {
   return Py.newSyntaxError(
    filename: filename,
    line: error.location.line,
    column: error.location.column,
    text: String(describing: error)
    )
  }

  public func newSyntaxError(filename: String,
                             error: ParserError) -> PySyntaxError {
   return Py.newSyntaxError(
    filename: filename,
    line: error.location.line,
    column: error.location.column,
    text: String(describing: error)
    )
  }

  public func newSyntaxError(filename: String,
                             error: CompilerError) -> PySyntaxError {
   return Py.newSyntaxError(
    filename: filename,
    line: error.location.line,
    column: error.location.column,
    text: String(describing: error)
    )
  }

  public func newSyntaxError(filename: String,
                             line: SourceLine,
                             column: SourceColumn,
                             text: String) -> PySyntaxError {
    return self.newSyntaxError(
      filename: Py.newString(filename),
      line: Py.newInt(Int(line)),
      column: Py.newInt(Int(column)),
      text: Py.newString(text)
    )
  }

  public func newSyntaxError(filename: PyString,
                             line: PyInt,
                             column: PyInt,
                             text: PyString) -> PySyntaxError {
    let args = Py.newTuple([filename, line, column, text])
    let e = PySyntaxError(args: args)

    let dict = e.__dict__
    dict.set(id: .filename, to: filename)
    dict.set(id: .lineno, to: line)
    dict.set(id: .offset, to: column)
    dict.set(id: .text, to: text)

    return e
  }

  // MARK: - Factory from type

  /// static PyObject*
  /// _PyErr_CreateException(PyObject *exception, PyObject *value)
  public func newException(type: PyType,
                           value: PyObject?) -> PyResult<PyBaseException> {
    guard type.isException else {
      return .typeError("exceptions must derive from BaseException")
    }

    switch self.callExceptionType(type: type, arg: value) {
    case let .value(object):
      guard let exception = object as? PyBaseException else {
        let msg = "calling \(type.getName()) should have returned " +
        "an instance of BaseException, not \(object.typeName)"
        return .typeError(msg)
      }

      return .value(exception)

    case let .error(e), let .notCallable(e):
      return .error(e)
    }
  }

  private func callExceptionType(type: PyType, arg: PyObject?) -> CallResult {
    guard let arg = arg else {
      return Py.call(callable: type, args: [])
    }

    if arg is PyNone {
      return Py.call(callable: type, args: [])
    }

    if let argTuple = arg as? PyTuple {
      return Py.call(callable: type, args: argTuple.elements)
    }

    return Py.call(callable: type, args: [arg])
  }
}

extension BuiltinFunctions {

  // MARK: - Exception matches

  /// Check if a given `error` is an instance of `exceptionType`.
  ///
  /// CPython:
  /// ```py
  /// int
  /// PyErr_GivenExceptionMatches(PyObject *err, PyObject *exc)
  /// ```
  ///
  /// - Parameters:
  ///   - error: Exception instance/type.
  ///   - exceptionType: Exception type to check agains (tuples are also allowed).
  public func exceptionMatches(error: PyObject,
                               exceptionType: PyObject) -> Bool {
    if let tuple = exceptionType as? PyTuple {
      return self.exceptionMatches(error: error, exceptionTypes: tuple)
    }

    if let type = exceptionType as? PyType {
      return self.exceptionMatches(error: error, exceptionType: type)
    }

    return false
  }

  public func exceptionMatches(error: PyObject,
                               exceptionTypes: PyTuple) -> Bool {
    return exceptionTypes.elements.contains {
      self.exceptionMatches(error: error, exceptionType: $0)
    }
  }

  public func exceptionMatches(error: PyObject,
                               exceptionType: PyType) -> Bool {
    // 'error' is a type
    if let type = error as? PyType {
      return self.exceptionMatches(error: type, exceptionType: exceptionType)
    }

    // 'error' is an error instance, so check its class
    return self.exceptionMatches(error: error.type, exceptionType: exceptionType)
  }

  /// Final version of `exceptionMatches` where we compare types.
  private func exceptionMatches(error: PyType,
                                exceptionType: PyType) -> Bool {
    guard error.isException else {
      return false
    }

    guard exceptionType.isException else {
      return false
    }

    return error.isSubtype(of: exceptionType)
  }
}
