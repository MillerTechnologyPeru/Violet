
import _io
import types
import collections

NoneType = type(None)
NotImplementedType = type(NotImplemented)
ellipsis = type(...)
code = types.CodeType
module = types.ModuleType
function = types.FunctionType
method = types.MethodType
builtinFunction = types.BuiltinFunctionType
builtinMethod = types.BuiltinMethodType
SimpleNamespace = types.SimpleNamespace

iterator = collections.Iterator
callable_iterator = type(iter(str, None))
tuple_iterator = type(iter(()))

list_iterator = type(iter([]))
list_reverseiterator = type(reversed([]))

set_iterator = type(iter({ 1 }))

dict_items = type({}.items())
dict_itemiterator = type(iter({}.items()))
dict_keys = type({}.keys())
dict_keyiterator = type(iter({}.keys()))
dict_values = type({}.values())
dict_valueiterator = type(iter({}.values()))

str_iterator = type(iter(''))
bytes_iterator = type(iter(b''))
bytearray_iterator = type(iter(bytearray()))

range_iterator = type(iter(range(1)))

# We dont have '_io' module.
# Instead we use custom 'builtins.TextFile' based on '_io.TextIOWrapper'.
TextFile = _io.TextIOWrapper



types = {
  object: [
    '__eq__',
    '__ne__',
    '__lt__',
    '__le__',
    '__gt__',
    '__ge__',
    '__hash__',
    '__repr__',
    '__str__',
    '__format__',
    '__class__',
    '__dir__',
    '__getattribute__',
    '__setattr__',
    '__delattr__',
    '__subclasshook__',
    '__init_subclass__',
    '__new__',
    '__init__',
  ],
  type: [
    '__name__',
    '__qualname__',
    '__doc__',
    '__module__',
    '__bases__',
    '__dict__',
    '__class__',
    '__base__',
    '__mro__',
    '__repr__',
    '__subclasscheck__',
    '__instancecheck__',
    '__subclasses__',
    '__getattribute__',
    '__setattr__',
    '__delattr__',
    '__dir__',
    '__call__',
    '__new__',
    '__init__',
  ],
  bool: [
    '__class__',
    '__repr__',
    '__str__',
    '__and__',
    '__rand__',
    '__or__',
    '__ror__',
    '__xor__',
    '__rxor__',
    '__new__',
  ],
  builtinFunction: [
    '__class__',
    '__name__',
    '__qualname__',
    '__text_signature__',
    '__module__',
    '__self__',
    '__eq__',
    '__ne__',
    '__lt__',
    '__le__',
    '__gt__',
    '__ge__',
    '__hash__',
    '__repr__',
    '__getattribute__',
    '__get__',
    '__call__',
  ],
  builtinMethod: [
    '__name__',
    '__qualname__',
    '__text_signature__',
    '__module__',
    '__self__',
    '__eq__',
    '__ne__',
    '__lt__',
    '__le__',
    '__gt__',
    '__ge__',
    '__hash__',
    '__repr__',
    '__getattribute__',
    '__get__',
    '__call__',
  ],
  bytearray: [
    '__class__',
    '__eq__',
    '__ne__',
    '__lt__',
    '__le__',
    '__gt__',
    '__ge__',
    '__hash__',
    '__repr__',
    '__str__',
    '__getattribute__',
    '__len__',
    '__contains__',
    '__getitem__',
    'isalnum',
    'isalpha',
    'isascii',
    'isdigit',
    'islower',
    'isspace',
    'istitle',
    'isupper',
    'startswith',
    'endswith',
    'strip',
    'lstrip',
    'rstrip',
    'find',
    'rfind',
    'index',
    'rindex',
    'lower',
    'upper',
    'title',
    'swapcase',
    'capitalize',
    'center',
    'ljust',
    'rjust',
    'split',
    'rsplit',
    'splitlines',
    'partition',
    'rpartition',
    'expandtabs',
    'count',
    'join',
    'replace',
    'zfill',
    '__add__',
    '__mul__',
    '__rmul__',
    '__iter__',
    '__new__',
    '__init__',
    'append',
    'extend',
    'insert',
    'remove',
    'pop',
    '__setitem__',
    '__delitem__',
    'clear',
    'reverse',
    'copy',
  ],
  bytearray_iterator: [
    '__class__',
    '__getattribute__',
    '__iter__',
    '__next__',
    '__new__',
  ],
  bytes: [
    '__class__',
    '__eq__',
    '__ne__',
    '__lt__',
    '__le__',
    '__gt__',
    '__ge__',
    '__hash__',
    '__repr__',
    '__str__',
    '__getattribute__',
    '__len__',
    '__contains__',
    '__getitem__',
    'isalnum',
    'isalpha',
    'isascii',
    'isdigit',
    'islower',
    'isspace',
    'istitle',
    'isupper',
    'startswith',
    'endswith',
    'strip',
    'lstrip',
    'rstrip',
    'find',
    'rfind',
    'index',
    'rindex',
    'lower',
    'upper',
    'title',
    'swapcase',
    'capitalize',
    'center',
    'ljust',
    'rjust',
    'split',
    'rsplit',
    'splitlines',
    'partition',
    'rpartition',
    'expandtabs',
    'count',
    'join',
    'replace',
    'zfill',
    '__add__',
    '__mul__',
    '__rmul__',
    '__iter__',
    '__new__',
  ],
  bytes_iterator: [
    '__class__',
    '__getattribute__',
    '__iter__',
    '__next__',
    '__new__',
  ],
  callable_iterator: [
    '__class__',
    '__getattribute__',
    '__iter__',
    '__next__',
  ],
  # 'cell' is not available in Python (it is only in CPython).
  # So we will skip it.
  classmethod: [
    '__class__',
    '__dict__',
    '__func__',
    '__get__',
    '__isabstractmethod__',
    '__new__',
    '__init__',
  ],
  code: [
    '__class__',
    '__eq__',
    '__ne__',
    '__lt__',
    '__le__',
    '__gt__',
    '__ge__',
    '__hash__',
    '__repr__',
  ],
  complex: [
    'real',
    'imag',
    '__class__',
    '__eq__',
    '__ne__',
    '__lt__',
    '__le__',
    '__gt__',
    '__ge__',
    '__hash__',
    '__repr__',
    '__str__',
    '__bool__',
    '__int__',
    '__float__',
    'conjugate',
    '__getattribute__',
    '__pos__',
    '__neg__',
    '__abs__',
    '__add__',
    '__radd__',
    '__sub__',
    '__rsub__',
    '__mul__',
    '__rmul__',
    '__pow__',
    '__rpow__',
    '__truediv__',
    '__rtruediv__',
    '__floordiv__',
    '__rfloordiv__',
    '__mod__',
    '__rmod__',
    '__divmod__',
    '__rdivmod__',
    '__new__',
  ],
  dict: [
    '__class__',
    '__eq__',
    '__ne__',
    '__lt__',
    '__le__',
    '__gt__',
    '__ge__',
    '__hash__',
    '__repr__',
    '__getattribute__',
    '__len__',
    '__getitem__',
    '__setitem__',
    '__delitem__',
    'get',
    'setdefault',
    '__contains__',
    '__iter__',
    'clear',
    'update',
    'copy',
    'pop',
    'popitem',
    'keys',
    'items',
    'values',
    '__new__',
    '__init__',
  ],
  dict_itemiterator: [
    '__class__',
    '__getattribute__',
    '__iter__',
    '__next__',
    '__new__',
  ],
  dict_items: [
    '__class__',
    '__eq__',
    '__ne__',
    '__lt__',
    '__le__',
    '__gt__',
    '__ge__',
    '__hash__',
    '__repr__',
    '__getattribute__',
    '__len__',
    '__contains__',
    '__iter__',
    '__new__',
  ],
  dict_keyiterator: [
    '__class__',
    '__getattribute__',
    '__iter__',
    '__next__',
    '__new__',
  ],
  dict_keys: [
    '__class__',
    '__eq__',
    '__ne__',
    '__lt__',
    '__le__',
    '__gt__',
    '__ge__',
    '__hash__',
    '__repr__',
    '__getattribute__',
    '__len__',
    '__contains__',
    '__iter__',
    '__new__',
  ],
  dict_valueiterator: [
    '__class__',
    '__getattribute__',
    '__iter__',
    '__next__',
    '__new__',
  ],
  dict_values: [
    '__repr__',
    '__getattribute__',
    '__len__',
    '__iter__',
  ],
  ellipsis: [
    '__class__',
    '__repr__',
    '__reduce__',
    '__getattribute__',
    '__new__',
  ],
  enumerate: [
    '__class__',
    '__getattribute__',
    '__iter__',
    '__next__',
    '__new__',
  ],
  filter: [
    '__class__',
    '__getattribute__',
    '__iter__',
    '__next__',
    '__new__',
  ],
  float: [
    'real',
    'imag',
    '__class__',
    '__eq__',
    '__ne__',
    '__lt__',
    '__le__',
    '__gt__',
    '__ge__',
    '__hash__',
    '__repr__',
    '__str__',
    '__bool__',
    '__int__',
    '__float__',
    'conjugate',
    '__getattribute__',
    '__pos__',
    '__neg__',
    '__abs__',
    'is_integer',
    '__add__',
    '__radd__',
    '__sub__',
    '__rsub__',
    '__mul__',
    '__rmul__',
    '__pow__',
    '__rpow__',
    '__truediv__',
    '__rtruediv__',
    '__floordiv__',
    '__rfloordiv__',
    '__mod__',
    '__rmod__',
    '__divmod__',
    '__rdivmod__',
    '__round__',
    '__trunc__',
    '__new__',
  ],
  frozenset: [
    '__class__',
    '__eq__',
    '__ne__',
    '__lt__',
    '__le__',
    '__gt__',
    '__ge__',
    '__hash__',
    '__repr__',
    '__getattribute__',
    '__len__',
    '__contains__',
    '__and__',
    '__rand__',
    '__or__',
    '__ror__',
    '__xor__',
    '__rxor__',
    '__sub__',
    '__rsub__',
    'issubset',
    'issuperset',
    'intersection',
    'union',
    'difference',
    'symmetric_difference',
    'isdisjoint',
    'copy',
    '__iter__',
    '__new__',
  ],
  function: [
    '__class__',
    '__name__',
    '__qualname__',
    '__defaults__',
    '__kwdefaults__',
    '__closure__',
    '__globals__',
    '__annotations__',
    '__code__',
    '__doc__',
    '__module__',
    '__dict__',
    '__repr__',
    '__get__',
    '__call__',
  ],
  int: [
    '__class__',
    'real',
    'imag',
    'numerator',
    'denominator',
    '__eq__',
    '__ne__',
    '__lt__',
    '__le__',
    '__gt__',
    '__ge__',
    '__hash__',
    '__repr__',
    '__str__',
    '__bool__',
    '__int__',
    '__float__',
    '__index__',
    'conjugate',
    '__getattribute__',
    '__pos__',
    '__neg__',
    '__abs__',
    '__trunc__',
    '__floor__',
    '__ceil__',
    'bit_length',
    '__add__',
    '__radd__',
    '__sub__',
    '__rsub__',
    '__mul__',
    '__rmul__',
    '__pow__',
    '__rpow__',
    '__truediv__',
    '__rtruediv__',
    '__floordiv__',
    '__rfloordiv__',
    '__mod__',
    '__rmod__',
    '__divmod__',
    '__rdivmod__',
    '__lshift__',
    '__rlshift__',
    '__rshift__',
    '__rrshift__',
    '__and__',
    '__rand__',
    '__or__',
    '__ror__',
    '__xor__',
    '__rxor__',
    '__invert__',
    '__round__',
    '__new__',
  ],
  iterator: [
    '__class__',
    '__getattribute__',
    '__iter__',
    '__next__',
  ],
  list: [
    '__class__',
    '__eq__',
    '__ne__',
    '__lt__',
    '__le__',
    '__gt__',
    '__ge__',
    '__hash__',
    '__repr__',
    '__getattribute__',
    '__len__',
    '__contains__',
    '__getitem__',
    '__setitem__',
    '__delitem__',
    'count',
    'index',
    '__iter__',
    '__reversed__',
    'append',
    'insert',
    'extend',
    'remove',
    'pop',
    'sort',
    'reverse',
    'clear',
    'copy',
    '__add__',
    '__iadd__',
    '__mul__',
    '__rmul__',
    '__imul__',
    '__new__',
    '__init__',
  ],
  list_iterator: [
    '__class__',
    '__getattribute__',
    '__iter__',
    '__next__',
    '__new__',
  ],
  list_reverseiterator: [
    '__class__',
    '__getattribute__',
    '__iter__',
    '__next__',
    '__new__',
  ],
  map: [
    '__class__',
    '__getattribute__',
    '__iter__',
    '__next__',
    '__new__',
  ],
  method: [
    '__class__',
    '__eq__',
    '__ne__',
    '__lt__',
    '__le__',
    '__gt__',
    '__ge__',
    '__repr__',
    '__hash__',
    '__getattribute__',
    '__setattr__',
    '__delattr__',
    '__func__',
    '__self__',
    '__get__',
    '__call__',
  ],
  module: [
    '__dict__',
    '__class__',
    '__repr__',
    '__getattribute__',
    '__setattr__',
    '__delattr__',
    '__dir__',
    '__new__',
    '__init__',
  ],
  types.SimpleNamespace: [
    '__dict__',
    '__eq__',
    '__ne__',
    '__lt__',
    '__le__',
    '__gt__',
    '__ge__',
    '__repr__',
    '__getattribute__',
    '__setattr__',
    '__delattr__',
    '__init__',
  ],
  NoneType: [
    '__class__',
    '__repr__',
    '__bool__',
    '__getattribute__',
    '__new__',
  ],
  NotImplementedType: [
    '__class__',
    '__repr__',
    '__new__',
  ],
  property: [
    '__class__',
    'fget',
    'fset',
    'fdel',
    '__getattribute__',
    '__get__',
    '__set__',
    '__delete__',
    '__new__',
    '__init__',
  ],
  range: [
    '__class__',
    'start',
    'stop',
    'step',
    '__eq__',
    '__ne__',
    '__lt__',
    '__le__',
    '__gt__',
    '__ge__',
    '__hash__',
    '__repr__',
    '__bool__',
    '__len__',
    '__getattribute__',
    '__contains__',
    '__getitem__',
    '__reversed__',
    '__iter__',
    'count',
    'index',
    '__new__',
  ],
  range_iterator: [
    '__class__',
    '__getattribute__',
    '__iter__',
    '__next__',
    '__new__',
  ],
  reversed: [
    '__class__',
    '__getattribute__',
    '__iter__',
    '__next__',
    '__new__',
  ],
  set: [
    '__class__',
    '__eq__',
    '__ne__',
    '__lt__',
    '__le__',
    '__gt__',
    '__ge__',
    '__hash__',
    '__repr__',
    '__getattribute__',
    '__len__',
    '__contains__',
    '__and__',
    '__rand__',
    '__or__',
    '__ror__',
    '__xor__',
    '__rxor__',
    '__sub__',
    '__rsub__',
    'issubset',
    'issuperset',
    'intersection',
    'union',
    'difference',
    'symmetric_difference',
    'isdisjoint',
    'add',
    'update',
    'remove',
    'discard',
    'clear',
    'copy',
    'pop',
    '__iter__',
    '__new__',
    '__init__',
  ],
  set_iterator: [
    '__class__',
    '__getattribute__',
    '__iter__',
    '__next__',
    '__new__',
  ],
  slice: [
    '__class__',
    'start',
    'stop',
    'step',
    '__eq__',
    '__ne__',
    '__lt__',
    '__le__',
    '__gt__',
    '__ge__',
    '__hash__',
    '__repr__',
    '__getattribute__',
    'indices',
    '__new__',
  ],
  staticmethod: [
    '__class__',
    '__dict__',
    '__func__',
    '__get__',
    '__isabstractmethod__',
    '__new__',
    '__init__',
  ],
  str: [
    '__class__',
    '__eq__',
    '__ne__',
    '__lt__',
    '__le__',
    '__gt__',
    '__ge__',
    '__hash__',
    '__repr__',
    '__str__',
    '__getattribute__',
    '__len__',
    '__contains__',
    '__getitem__',
    'isalnum',
    'isalpha',
    'isascii',
    'isdecimal',
    'isdigit',
    'isidentifier',
    'islower',
    'isnumeric',
    'isprintable',
    'isspace',
    'istitle',
    'isupper',
    'startswith',
    'endswith',
    'strip',
    'lstrip',
    'rstrip',
    'find',
    'rfind',
    'index',
    'rindex',
    'lower',
    'upper',
    'title',
    'swapcase',
    'casefold',
    'capitalize',
    'center',
    'ljust',
    'rjust',
    'split',
    'rsplit',
    'splitlines',
    'partition',
    'rpartition',
    'expandtabs',
    'count',
    'join',
    'replace',
    'zfill',
    '__add__',
    '__mul__',
    '__rmul__',
    '__iter__',
    '__new__',
  ],
  str_iterator: [
    '__class__',
    '__getattribute__',
    '__iter__',
    '__next__',
    '__new__',
  ],
  TextFile: [
    '__class__',
    '__repr__',
    'readable',
    'read',
    'writable',
    'write',
    'closed',
    'close',
    '__del__',
  ],
  tuple: [
    '__class__',
    '__eq__',
    '__ne__',
    '__lt__',
    '__le__',
    '__gt__',
    '__ge__',
    '__hash__',
    '__repr__',
    '__getattribute__',
    '__len__',
    '__contains__',
    '__getitem__',
    'count',
    'index',
    '__iter__',
    '__add__',
    '__mul__',
    '__rmul__',
    '__new__',
  ],
  tuple_iterator: [
    '__class__',
    '__getattribute__',
    '__iter__',
    '__next__',
    '__new__',
  ],
  zip: [
    '__class__',
    '__getattribute__',
    '__iter__',
    '__next__',
    '__new__',
  ],
  ArithmeticError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  AssertionError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  AttributeError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  BaseException: [
    '__dict__',
    '__class__',
    'args',
    '__traceback__',
    '__cause__',
    '__context__',
    '__suppress_context__',
    '__repr__',
    '__str__',
    '__getattribute__',
    '__setattr__',
    '__delattr__',
    '__new__',
    '__init__',
  ],
  BlockingIOError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  BrokenPipeError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  BufferError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  BytesWarning: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  ChildProcessError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  ConnectionAbortedError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  ConnectionError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  ConnectionRefusedError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  ConnectionResetError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  DeprecationWarning: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  EOFError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  Exception: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  FileExistsError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  FileNotFoundError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  FloatingPointError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  FutureWarning: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  GeneratorExit: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  ImportError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  ImportWarning: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  IndentationError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  IndexError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  InterruptedError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  IsADirectoryError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  KeyError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  KeyboardInterrupt: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  LookupError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  MemoryError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  ModuleNotFoundError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  NameError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  NotADirectoryError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  NotImplementedError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  OSError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  OverflowError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  PendingDeprecationWarning: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  PermissionError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  ProcessLookupError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  RecursionError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  ReferenceError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  ResourceWarning: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  RuntimeError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  RuntimeWarning: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  StopAsyncIteration: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  StopIteration: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  SyntaxError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  SyntaxWarning: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  SystemError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  SystemExit: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  TabError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  TimeoutError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  TypeError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  UnboundLocalError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  UnicodeDecodeError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  UnicodeEncodeError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  UnicodeError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  UnicodeTranslateError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  UnicodeWarning: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  UserWarning: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  ValueError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  Warning: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
  ZeroDivisionError: [
    '__class__',
    '__dict__',
    '__new__',
    '__init__',
  ],
}
