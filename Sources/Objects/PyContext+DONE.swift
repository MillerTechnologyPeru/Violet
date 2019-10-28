import Core

extension PyContext {

  // MARK: - Int

  public func int(_ value: Int) -> PyObject {
    return self._int(value)
  }

  internal func _int(_ value: Int) -> PyInt {
    return PyInt(self, value: BigInt(value))
  }

  public func int(_ value: BigInt) -> PyObject {
    return self._int(value)
  }

  internal func _int(_ value: BigInt) -> PyInt {
    return PyInt(self, value: value)
  }

  // MARK: - Float

  public func float(_ value: Double) -> PyObject {
    return self._float(value)
  }

  internal func _float(_ value: Double) -> PyFloat {
    return PyFloat(self, value: value)
  }

  // MARK: - Complex

  public func complex(real: Double, imag: Double) -> PyObject {
    return self._complex(real: real, imag: imag)
  }

  internal func _complex(real: Double, imag: Double) -> PyComplex {
    return PyComplex(self, real: real, imag: imag)
  }

  // MARK: - String

  public func string(_ value: String) -> PyObject {
    return self._string(value)
  }

  internal func _string(_ value: String) -> PyString {
    return PyString(self, value: value)
  }

  // MARK: - Bool

  public func not(value: PyObject) -> Bool {
    return false
  }

  public func isTrue(value: PyObject) -> Bool {
    return true
  }

  public func `is`(left: PyObject, right: PyObject) -> Bool {
    return false
  }

  // MARK: - Repr

  /// PyObject * PyObject_Repr(PyObject *v)
  public func repr(value: PyObject) -> PyObject {
    let raw = self._repr(value: value)
    return PyString(self, value: raw)
  }

  internal func _repr(value: PyObject) -> String {
//    if let reprType = value as? ReprTypeClass {
//      return reprType.repr()
//    }
//
//    return self.genericRepr(value: value)
    return ""
  }

  // MARK: - ASCII

  /// PyObject * PyObject_ASCII(PyObject *v)
  public func ascii(value: PyObject) -> PyObject {
    let raw = self.asciiStr(value: value)
    return PyString(self, value: raw)
  }

  internal func asciiStr(value: PyObject) -> String {
    let repr = self._repr(value: value)
    let scalars = repr.unicodeScalars

    let allASCII = scalars.allSatisfy { $0.isASCII }
    if allASCII {
      return repr
    }

    var result = ""
    for scalar in scalars {
      if scalar.isASCII {
        result.append(String(scalar))
      } else if scalar.value < 0x10000 {
        // \uxxxx Character with 16-bit hex value xxxx
        result.append("\\u\(self.hex(scalar.value, padTo: 4))")
      } else {
        // \Uxxxxxxxx Character with 32-bit hex value xxxxxxxx
        result.append("\\U\(self.hex(scalar.value, padTo: 8))")
      }
    }

    return result
  }

  private func hex(_ value: UInt32, padTo: Int) -> String {
    let raw = String(value, radix: 16, uppercase: false)
    return raw.padding(toLength: padTo, withPad: "0", startingAt: 0)
  }

  // MARK: - Helpers

  private func genericRepr(value: PyObject) -> String {
    return "<\(value.typeName) object at \(value.ptrString)>"
  }

  // MARK: - Hash

  /// Py_hash_t PyObject_Hash(PyObject *v)
  internal func hash(value: PyObject) -> PyHash {
    return 0
  }
}
