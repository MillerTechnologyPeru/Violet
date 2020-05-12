// swiftlint:disable line_length
// swiftlint:disable trailing_newline
// swiftlint:disable file_length

// Please note that this file was automatically generated. DO NOT EDIT!
// The same goes for other files in 'Generated' directory.

// In CPython:
// Objects -> exceptions.c
// Lib->test->exception_hierarchy.txt <-- this is amazing
// https://docs.python.org/3.7/library/exceptions.html
// https://docs.python.org/3.7/c-api/exceptions.html

// MARK: - SystemExit

// sourcery: pyerrortype = SystemExit, default, baseType, hasGC, baseExceptionSubclass
public final class PySystemExit: PyBaseException {

  override internal class var doc: String {
    return "Request to exit from the interpreter."
  }

  override public var description: String {
    return self.createDescription(typeName: "PySystemExit")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.systemExit
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PySystemExit(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - KeyboardInterrupt

// sourcery: pyerrortype = KeyboardInterrupt, default, baseType, hasGC, baseExceptionSubclass
public final class PyKeyboardInterrupt: PyBaseException {

  override internal class var doc: String {
    return "Program interrupted by user."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyKeyboardInterrupt")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.keyboardInterrupt
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyKeyboardInterrupt(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - GeneratorExit

// sourcery: pyerrortype = GeneratorExit, default, baseType, hasGC, baseExceptionSubclass
public final class PyGeneratorExit: PyBaseException {

  override internal class var doc: String {
    return "Request that a generator exit."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyGeneratorExit")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.generatorExit
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyGeneratorExit(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - Exception

// sourcery: pyerrortype = Exception, default, baseType, hasGC, baseExceptionSubclass
public class PyException: PyBaseException {

  override internal class var doc: String {
    return "Common base class for all non-exit exceptions."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyException")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.exception
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyException(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - StopAsyncIteration

// sourcery: pyerrortype = StopAsyncIteration, default, baseType, hasGC, baseExceptionSubclass
public final class PyStopAsyncIteration: PyException {

  override internal class var doc: String {
    return "Signal the end from iterator.__anext__()."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyStopAsyncIteration")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.stopAsyncIteration
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyStopAsyncIteration(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - ArithmeticError

// sourcery: pyerrortype = ArithmeticError, default, baseType, hasGC, baseExceptionSubclass
public class PyArithmeticError: PyException {

  override internal class var doc: String {
    return "Base class for arithmetic errors."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyArithmeticError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.arithmeticError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyArithmeticError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - FloatingPointError

// sourcery: pyerrortype = FloatingPointError, default, baseType, hasGC, baseExceptionSubclass
public final class PyFloatingPointError: PyArithmeticError {

  override internal class var doc: String {
    return "Floating point operation failed."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyFloatingPointError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.floatingPointError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyFloatingPointError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - OverflowError

// sourcery: pyerrortype = OverflowError, default, baseType, hasGC, baseExceptionSubclass
public final class PyOverflowError: PyArithmeticError {

  override internal class var doc: String {
    return "Result too large to be represented."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyOverflowError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.overflowError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyOverflowError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - ZeroDivisionError

// sourcery: pyerrortype = ZeroDivisionError, default, baseType, hasGC, baseExceptionSubclass
public final class PyZeroDivisionError: PyArithmeticError {

  override internal class var doc: String {
    return "Second argument to a division or modulo operation was zero."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyZeroDivisionError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.zeroDivisionError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyZeroDivisionError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - AssertionError

// sourcery: pyerrortype = AssertionError, default, baseType, hasGC, baseExceptionSubclass
public final class PyAssertionError: PyException {

  override internal class var doc: String {
    return "Assertion failed."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyAssertionError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.assertionError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyAssertionError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - AttributeError

// sourcery: pyerrortype = AttributeError, default, baseType, hasGC, baseExceptionSubclass
public final class PyAttributeError: PyException {

  override internal class var doc: String {
    return "Attribute not found."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyAttributeError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.attributeError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyAttributeError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - BufferError

// sourcery: pyerrortype = BufferError, default, baseType, hasGC, baseExceptionSubclass
public final class PyBufferError: PyException {

  override internal class var doc: String {
    return "Buffer error."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyBufferError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.bufferError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyBufferError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - EOFError

// sourcery: pyerrortype = EOFError, default, baseType, hasGC, baseExceptionSubclass
public final class PyEOFError: PyException {

  override internal class var doc: String {
    return "Read beyond end of file."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyEOFError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.eofError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyEOFError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - ImportError

// sourcery: pyerrortype = ImportError, default, baseType, hasGC, baseExceptionSubclass
public class PyImportError: PyException {

  override internal class var doc: String {
    return "Import can't find module, or can't find name in module."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyImportError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.importError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyImportError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - ModuleNotFoundError

// sourcery: pyerrortype = ModuleNotFoundError, default, baseType, hasGC, baseExceptionSubclass
public final class PyModuleNotFoundError: PyImportError {

  override internal class var doc: String {
    return "Module not found."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyModuleNotFoundError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.moduleNotFoundError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyModuleNotFoundError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - LookupError

// sourcery: pyerrortype = LookupError, default, baseType, hasGC, baseExceptionSubclass
public class PyLookupError: PyException {

  override internal class var doc: String {
    return "Base class for lookup errors."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyLookupError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.lookupError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyLookupError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - IndexError

// sourcery: pyerrortype = IndexError, default, baseType, hasGC, baseExceptionSubclass
public final class PyIndexError: PyLookupError {

  override internal class var doc: String {
    return "Sequence index out of range."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyIndexError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.indexError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyIndexError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - MemoryError

// sourcery: pyerrortype = MemoryError, default, baseType, hasGC, baseExceptionSubclass
public final class PyMemoryError: PyException {

  override internal class var doc: String {
    return "Out of memory."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyMemoryError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.memoryError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyMemoryError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - NameError

// sourcery: pyerrortype = NameError, default, baseType, hasGC, baseExceptionSubclass
public class PyNameError: PyException {

  override internal class var doc: String {
    return "Name not found globally."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyNameError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.nameError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyNameError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - UnboundLocalError

// sourcery: pyerrortype = UnboundLocalError, default, baseType, hasGC, baseExceptionSubclass
public final class PyUnboundLocalError: PyNameError {

  override internal class var doc: String {
    return "Local name referenced but not bound to a value."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyUnboundLocalError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.unboundLocalError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyUnboundLocalError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - OSError

// sourcery: pyerrortype = OSError, default, baseType, hasGC, baseExceptionSubclass
public class PyOSError: PyException {

  override internal class var doc: String {
    return "Base class for I/O related errors."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyOSError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.osError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyOSError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - BlockingIOError

// sourcery: pyerrortype = BlockingIOError, default, baseType, hasGC, baseExceptionSubclass
public final class PyBlockingIOError: PyOSError {

  override internal class var doc: String {
    return "I/O operation would block."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyBlockingIOError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.blockingIOError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyBlockingIOError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - ChildProcessError

// sourcery: pyerrortype = ChildProcessError, default, baseType, hasGC, baseExceptionSubclass
public final class PyChildProcessError: PyOSError {

  override internal class var doc: String {
    return "Child process error."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyChildProcessError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.childProcessError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyChildProcessError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - ConnectionError

// sourcery: pyerrortype = ConnectionError, default, baseType, hasGC, baseExceptionSubclass
public class PyConnectionError: PyOSError {

  override internal class var doc: String {
    return "Connection error."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyConnectionError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.connectionError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyConnectionError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - BrokenPipeError

// sourcery: pyerrortype = BrokenPipeError, default, baseType, hasGC, baseExceptionSubclass
public final class PyBrokenPipeError: PyConnectionError {

  override internal class var doc: String {
    return "Broken pipe."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyBrokenPipeError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.brokenPipeError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyBrokenPipeError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - ConnectionAbortedError

// sourcery: pyerrortype = ConnectionAbortedError, default, baseType, hasGC, baseExceptionSubclass
public final class PyConnectionAbortedError: PyConnectionError {

  override internal class var doc: String {
    return "Connection aborted."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyConnectionAbortedError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.connectionAbortedError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyConnectionAbortedError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - ConnectionRefusedError

// sourcery: pyerrortype = ConnectionRefusedError, default, baseType, hasGC, baseExceptionSubclass
public final class PyConnectionRefusedError: PyConnectionError {

  override internal class var doc: String {
    return "Connection refused."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyConnectionRefusedError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.connectionRefusedError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyConnectionRefusedError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - ConnectionResetError

// sourcery: pyerrortype = ConnectionResetError, default, baseType, hasGC, baseExceptionSubclass
public final class PyConnectionResetError: PyConnectionError {

  override internal class var doc: String {
    return "Connection reset."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyConnectionResetError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.connectionResetError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyConnectionResetError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - FileExistsError

// sourcery: pyerrortype = FileExistsError, default, baseType, hasGC, baseExceptionSubclass
public final class PyFileExistsError: PyOSError {

  override internal class var doc: String {
    return "File already exists."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyFileExistsError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.fileExistsError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyFileExistsError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - FileNotFoundError

// sourcery: pyerrortype = FileNotFoundError, default, baseType, hasGC, baseExceptionSubclass
public final class PyFileNotFoundError: PyOSError {

  override internal class var doc: String {
    return "File not found."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyFileNotFoundError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.fileNotFoundError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyFileNotFoundError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - InterruptedError

// sourcery: pyerrortype = InterruptedError, default, baseType, hasGC, baseExceptionSubclass
public final class PyInterruptedError: PyOSError {

  override internal class var doc: String {
    return "Interrupted by signal."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyInterruptedError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.interruptedError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyInterruptedError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - IsADirectoryError

// sourcery: pyerrortype = IsADirectoryError, default, baseType, hasGC, baseExceptionSubclass
public final class PyIsADirectoryError: PyOSError {

  override internal class var doc: String {
    return "Operation doesn't work on directories."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyIsADirectoryError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.isADirectoryError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyIsADirectoryError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - NotADirectoryError

// sourcery: pyerrortype = NotADirectoryError, default, baseType, hasGC, baseExceptionSubclass
public final class PyNotADirectoryError: PyOSError {

  override internal class var doc: String {
    return "Operation only works on directories."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyNotADirectoryError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.notADirectoryError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyNotADirectoryError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - PermissionError

// sourcery: pyerrortype = PermissionError, default, baseType, hasGC, baseExceptionSubclass
public final class PyPermissionError: PyOSError {

  override internal class var doc: String {
    return "Not enough permissions."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyPermissionError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.permissionError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyPermissionError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - ProcessLookupError

// sourcery: pyerrortype = ProcessLookupError, default, baseType, hasGC, baseExceptionSubclass
public final class PyProcessLookupError: PyOSError {

  override internal class var doc: String {
    return "Process not found."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyProcessLookupError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.processLookupError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyProcessLookupError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - TimeoutError

// sourcery: pyerrortype = TimeoutError, default, baseType, hasGC, baseExceptionSubclass
public final class PyTimeoutError: PyOSError {

  override internal class var doc: String {
    return "Timeout expired."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyTimeoutError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.timeoutError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyTimeoutError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - ReferenceError

// sourcery: pyerrortype = ReferenceError, default, baseType, hasGC, baseExceptionSubclass
public final class PyReferenceError: PyException {

  override internal class var doc: String {
    return "Weak ref proxy used after referent went away."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyReferenceError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.referenceError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyReferenceError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - RuntimeError

// sourcery: pyerrortype = RuntimeError, default, baseType, hasGC, baseExceptionSubclass
public class PyRuntimeError: PyException {

  override internal class var doc: String {
    return "Unspecified run-time error."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyRuntimeError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.runtimeError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyRuntimeError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - NotImplementedError

// sourcery: pyerrortype = NotImplementedError, default, baseType, hasGC, baseExceptionSubclass
public final class PyNotImplementedError: PyRuntimeError {

  override internal class var doc: String {
    return "Method or function hasn't been implemented yet."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyNotImplementedError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.notImplementedError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyNotImplementedError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - RecursionError

// sourcery: pyerrortype = RecursionError, default, baseType, hasGC, baseExceptionSubclass
public final class PyRecursionError: PyRuntimeError {

  override internal class var doc: String {
    return "Recursion limit exceeded."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyRecursionError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.recursionError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyRecursionError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - SyntaxError

// sourcery: pyerrortype = SyntaxError, default, baseType, hasGC, baseExceptionSubclass
public class PySyntaxError: PyException {

  override internal class var doc: String {
    return "Invalid syntax."
  }

  override public var description: String {
    return self.createDescription(typeName: "PySyntaxError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.syntaxError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PySyntaxError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - IndentationError

// sourcery: pyerrortype = IndentationError, default, baseType, hasGC, baseExceptionSubclass
public class PyIndentationError: PySyntaxError {

  override internal class var doc: String {
    return "Improper indentation."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyIndentationError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.indentationError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyIndentationError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - TabError

// sourcery: pyerrortype = TabError, default, baseType, hasGC, baseExceptionSubclass
public final class PyTabError: PyIndentationError {

  override internal class var doc: String {
    return "Improper mixture of spaces and tabs."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyTabError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.tabError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyTabError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - SystemError

// sourcery: pyerrortype = SystemError, default, baseType, hasGC, baseExceptionSubclass
public final class PySystemError: PyException {

  override internal class var doc: String {
    return "Internal error in the Python interpreter. " +
" " +
"Please report this to the Python maintainer, along with the traceback, " +
"the Python version, and the hardware/OS platform and version."
  }

  override public var description: String {
    return self.createDescription(typeName: "PySystemError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.systemError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PySystemError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - TypeError

// sourcery: pyerrortype = TypeError, default, baseType, hasGC, baseExceptionSubclass
public final class PyTypeError: PyException {

  override internal class var doc: String {
    return "Inappropriate argument type."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyTypeError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.typeError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyTypeError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - ValueError

// sourcery: pyerrortype = ValueError, default, baseType, hasGC, baseExceptionSubclass
public class PyValueError: PyException {

  override internal class var doc: String {
    return "Inappropriate argument value (of correct type)."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyValueError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.valueError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyValueError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - UnicodeError

// sourcery: pyerrortype = UnicodeError, default, baseType, hasGC, baseExceptionSubclass
public class PyUnicodeError: PyValueError {

  override internal class var doc: String {
    return "Unicode related error."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyUnicodeError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.unicodeError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyUnicodeError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - UnicodeDecodeError

// sourcery: pyerrortype = UnicodeDecodeError, default, baseType, hasGC, baseExceptionSubclass
public final class PyUnicodeDecodeError: PyUnicodeError {

  override internal class var doc: String {
    return "Unicode decoding error."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyUnicodeDecodeError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.unicodeDecodeError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyUnicodeDecodeError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - UnicodeEncodeError

// sourcery: pyerrortype = UnicodeEncodeError, default, baseType, hasGC, baseExceptionSubclass
public final class PyUnicodeEncodeError: PyUnicodeError {

  override internal class var doc: String {
    return "Unicode encoding error."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyUnicodeEncodeError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.unicodeEncodeError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyUnicodeEncodeError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - UnicodeTranslateError

// sourcery: pyerrortype = UnicodeTranslateError, default, baseType, hasGC, baseExceptionSubclass
public final class PyUnicodeTranslateError: PyUnicodeError {

  override internal class var doc: String {
    return "Unicode translation error."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyUnicodeTranslateError")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.unicodeTranslateError
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyUnicodeTranslateError(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - Warning

// sourcery: pyerrortype = Warning, default, baseType, hasGC, baseExceptionSubclass
public class PyWarning: PyException {

  override internal class var doc: String {
    return "Base class for warning categories."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyWarning")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.warning
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyWarning(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - DeprecationWarning

// sourcery: pyerrortype = DeprecationWarning, default, baseType, hasGC, baseExceptionSubclass
public final class PyDeprecationWarning: PyWarning {

  override internal class var doc: String {
    return "Base class for warnings about deprecated features."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyDeprecationWarning")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.deprecationWarning
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyDeprecationWarning(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - PendingDeprecationWarning

// sourcery: pyerrortype = PendingDeprecationWarning, default, baseType, hasGC, baseExceptionSubclass
public final class PyPendingDeprecationWarning: PyWarning {

  override internal class var doc: String {
    return "Base class for warnings about features which will be deprecated " +
"in the future."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyPendingDeprecationWarning")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.pendingDeprecationWarning
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyPendingDeprecationWarning(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - RuntimeWarning

// sourcery: pyerrortype = RuntimeWarning, default, baseType, hasGC, baseExceptionSubclass
public final class PyRuntimeWarning: PyWarning {

  override internal class var doc: String {
    return "Base class for warnings about dubious runtime behavior."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyRuntimeWarning")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.runtimeWarning
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyRuntimeWarning(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - SyntaxWarning

// sourcery: pyerrortype = SyntaxWarning, default, baseType, hasGC, baseExceptionSubclass
public final class PySyntaxWarning: PyWarning {

  override internal class var doc: String {
    return "Base class for warnings about dubious syntax."
  }

  override public var description: String {
    return self.createDescription(typeName: "PySyntaxWarning")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.syntaxWarning
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PySyntaxWarning(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - UserWarning

// sourcery: pyerrortype = UserWarning, default, baseType, hasGC, baseExceptionSubclass
public final class PyUserWarning: PyWarning {

  override internal class var doc: String {
    return "Base class for warnings generated by user code."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyUserWarning")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.userWarning
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyUserWarning(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - FutureWarning

// sourcery: pyerrortype = FutureWarning, default, baseType, hasGC, baseExceptionSubclass
public final class PyFutureWarning: PyWarning {

  override internal class var doc: String {
    return "Base class for warnings about constructs that will change semantically " +
"in the future."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyFutureWarning")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.futureWarning
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyFutureWarning(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - ImportWarning

// sourcery: pyerrortype = ImportWarning, default, baseType, hasGC, baseExceptionSubclass
public final class PyImportWarning: PyWarning {

  override internal class var doc: String {
    return "Base class for warnings about probable mistakes in module imports"
  }

  override public var description: String {
    return self.createDescription(typeName: "PyImportWarning")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.importWarning
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyImportWarning(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - UnicodeWarning

// sourcery: pyerrortype = UnicodeWarning, default, baseType, hasGC, baseExceptionSubclass
public final class PyUnicodeWarning: PyWarning {

  override internal class var doc: String {
    return "Base class for warnings about Unicode related problems, mostly " +
"related to conversion problems."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyUnicodeWarning")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.unicodeWarning
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyUnicodeWarning(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - BytesWarning

// sourcery: pyerrortype = BytesWarning, default, baseType, hasGC, baseExceptionSubclass
public final class PyBytesWarning: PyWarning {

  override internal class var doc: String {
    return "Base class for warnings about bytes and buffer related problems, mostly " +
"related to conversion from str or comparing to str."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyBytesWarning")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.bytesWarning
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyBytesWarning(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

// MARK: - ResourceWarning

// sourcery: pyerrortype = ResourceWarning, default, baseType, hasGC, baseExceptionSubclass
public final class PyResourceWarning: PyWarning {

  override internal class var doc: String {
    return "Base class for warnings about resource usage."
  }

  override public var description: String {
    return self.createDescription(typeName: "PyResourceWarning")
  }

  /// Type to set in `init`.
  override internal class var pythonType: PyType {
    return Py.errorTypes.resourceWarning
  }

  // sourcery: pyproperty = __class__
  override public func getClass() -> PyType {
    return self.type
  }

  // sourcery: pyproperty = __dict__
  override public func getDict() -> PyDict {
    return self.__dict__
  }

  // sourcery: pystaticmethod = __new__
  override internal class func pyNew(type: PyType,
                                     args: [PyObject],
                                     kwargs: PyDict?) -> PyResult<PyBaseException> {
    let argsTuple = Py.newTuple(args)
    return .value(PyResourceWarning(args: argsTuple, type: type))
  }

  // sourcery: pymethod = __init__
  override internal func pyInit(args: [PyObject],
                                kwargs: PyDict?) -> PyResult<PyNone> {
    return super.pyInit(args: args, kwargs: kwargs)
  }
}

