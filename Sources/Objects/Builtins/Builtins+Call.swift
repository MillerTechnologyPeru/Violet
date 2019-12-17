import Core

// In CPython:
// Objects -> call.c
// Python -> builtinmodule.c
// https://docs.python.org/3/library/functions.html

// Comment from CPython 'Python/ceval.h':
// PyObject_Call(), PyObject_CallFunction() and PyObject_CallMethod()
// are recommended to call a callable object.

public enum CallResult {
  case value(PyObject)
  case notImplemented
  case noSuchMethod(PyErrorEnum)
  case methodIsNotCallable(PyErrorEnum)
  case error(PyErrorEnum)
}

extension Builtins {

  // MARK: - Lookup

  /// Internal API to look for a name through the MRO.
  public func lookup(_ object: PyObject, name: String) -> PyObject? {
    return object.type.lookup(name: name)
  }

  // MARK: - Method

  public func callMethod(on object: PyObject,
                         selector: String,
                         args: PyObject,
                         kwargs: PyObject?) -> CallResult {
    let argsArray: [PyObject]
    switch ArgumentParser.unpackArgsTuple(args: args) {
    case let .value(o): argsArray = o
    case let .error(e): return .error(e)
    }

    switch ArgumentParser.unpackKwargsDict(kwargs: kwargs) {
    case let .value(kwargsDict):
      return self.callMethod(on: object,
                             selector: selector,
                             args: argsArray,
                             kwargs: kwargsDict)
    case let .error(e):
      return .error(e)
    }
  }

  /// Call method with single arg.
  internal func callMethod(on object: PyObject,
                           selector: String,
                           arg: PyObject) -> CallResult {
    return self.callMethod(on: object, selector: selector, args: [arg])
  }

  /// PyObject *
  /// PyObject_CallMethod(PyObject *obj, const char *name, const char *format, ...)
  internal func callMethod(on object: PyObject,
                           selector: String,
                           args: [PyObject] = [],
                           kwargs: PyDictData? = nil) -> CallResult {
    guard let boundMethod = self.lookup(object, name: selector) else {
      let msg = "'\(object.typeName)' object has no attribute '\(selector)'"
      return .noSuchMethod(.attributeError(msg))
    }

    if let owner = boundMethod as? __call__Owner {
      switch owner.call(args: args, kwargs: kwargs) {
      case .value(let result): return .value(result)
      case .notImplemented: return .notImplemented
      case .error(let e): return .error(e)
      }
    }

    // Case that is not supported in this method
    // (because it is actually a callable property):
    // >>> class F():
    // ...     def __call__(self, arg): print(arg)
    // >>> class C:
    // ...     def __init__(self, f): self.f = f
    //
    // >>> f = F()
    // >>> c = C(f)
    // >>> c.f(1) <-- we are calling method 'f' on object 'c'
    // 1

    let msg = "attribute of type '\(boundMethod.typeName)' is not callable"
    return .methodIsNotCallable(.typeError(msg))
  }
}
