from Data.types import get_types
from Common.builtin_types import get_property_name, get_property_name_escaped

all_types = get_types()
builtin_types = list(filter(lambda t: not t.is_error_type, all_types))

if __name__ == '__main__':
  print('''\
// swiftlint:disable function_body_length
// swiftlint:disable line_length
// swiftlint:disable trailing_comma
// swiftlint:disable vertical_whitespace

// Please note that this file was automatically generated. DO NOT EDIT!
// The same goes for other files in 'Generated' directory.

// Type initialization order:
//
// Stage 1: Create all type objects ('init()' function)
// Just instantiate all of the 'PyType' properties.
// At this point we can't fill '__dict__', because for this we would need other
// types to be already initialized (which would be circular).
// For example we can't fill '__doc__' because for this we would need 'str' type,
// which may not yet exist.
//
// Stage 2: Fill type objects ('fill__dict__()' method)
// When all of the types are initalized we can finally fill dictionaries.
''')

  print('public final class BuiltinTypes {')
  print()

  # ==================
  # === Properties ===
  # ==================

  for t in builtin_types:
    python_type = t.python_type
    property_name_escaped = get_property_name_escaped(python_type)
    print(f'  public let {property_name_escaped}: PyType')

  # ============
  # === Init ===
  # ============

  print('''
  /// Init that will only initialize properties.
  /// (see comment at the top of this file)
  internal init() {
    // Requirements (for 'self.object' and 'self.type'):
    // 1. 'type' inherits from 'object'
    // 2. both 'type' and 'object' are instances of 'type'
    self.object = PyType.initObjectType()
    self.type = PyType.initTypeType(objectType: self.object)
    self.object.setType(to: self.type)
    self.type.setType(to: self.type)

    // 'self.bool' has to be last because it uses 'self.int' as base!\
''')

  for t in builtin_types:
    python_type = t.python_type
    swift_type = t.swift_type
    property_name_escaped = get_property_name_escaped(python_type)

    # 'self.object' and 'self.type' are already initialized
    if python_type == 'object' or python_type == 'type':
      continue

    # 'self.bool' has to be last because it uses 'self.int' as base!
    if python_type == 'bool':
      continue

    print(f'    self.{property_name_escaped} = PyType.initBuiltinType(name: "{python_type}", type: self.type, base: self.object)')

  # And now add 'bool'
  print('    self.bool = PyType.initBuiltinType(name: "bool", type: self.type, base: self.int)')
  print('  }')
  print()

  # ====================
  # === fill__dict__ ===
  # ====================

  print('''\
  /// This function finalizes init of all of the stored types.
  /// (see comment at the top of this file)
  ///
  /// For example it will:
  /// - set type flags
  /// - add `__doc__`
  /// - fill `__dict__`
  internal func fill__dict__() {\
''')

  for t in builtin_types:
    python_type = t.python_type
    property_name_escaped = get_property_name_escaped(python_type)
    print(f'    FillTypes.{property_name_escaped}(self.{property_name_escaped})')

  print('  }')
  print()

  # ===========
  # === all ===
  # ===========

  print('''\
  internal var all: [PyType] {
    return [\
''')

  for t in builtin_types:
    python_type = t.python_type
    property_name_escaped = get_property_name_escaped(python_type)
    print(f'      self.{property_name_escaped},')

  print('    ]')
  print('  }')

  print('}')
