import inspect
import dump_type_methods_implemented as implemented

def dump(obj):
  for attr in dir(obj):
    print("obj.%s = %r" % (attr, getattr(obj, attr)))

for t in implemented.types:
  doc = None
  properties_implemented = []
  properties_unimplemented = []
  methods_implemented = []
  methods_unimplemented = []
  methods_derived = []
  members_from_sourcery = implemented.types[t]

  # TODO: Uncomment when we start '__new__' and '__init__'
  ignored = ['__new__', '__init__',
             '__init_subclass__', '__subclasshook__', '__reduce__', '__reduce_ex__']
  for name, member in inspect.getmembers(t):
    if name in ignored:
      continue
    elif name == '__doc__':
      doc = member
    elif hasattr(member, '__objclass__'):
      if member.__objclass__ == t:
        if name in members_from_sourcery:
          methods_implemented.append(member)
        else:
          methods_unimplemented.append(member)
      else:
        methods_derived.append(member)
    else:
      tpl = name, member
      if name in members_from_sourcery:
        properties_implemented.append(tpl)
      else:
        properties_unimplemented.append(tpl)

  why_is_this_even_implemented = []
  own_property_names = list(map(lambda m: m[0], properties_implemented + properties_unimplemented))
  own_methods_names = list(map(lambda m: m.__name__, methods_implemented + methods_unimplemented))
  own_names = own_methods_names + own_property_names
  for m in members_from_sourcery:
    if m not in own_names:
      why_is_this_even_implemented.append(m)

  print_implemented = 0
  print_unimplemented = 0
  print_why_is_this_even_implemented = 0
  print_derived = 0
  print_doc = 1

  # Skip finished types
  has_something_to_do = methods_unimplemented or why_is_this_even_implemented
  if not has_something_to_do:
    continue

  print(t.__name__)
  if print_implemented and (methods_implemented):
    print('  Implemented:')
    for name, member in properties_implemented:
      print('   ', name, '-', type(member))
    for m in methods_implemented:
      doc = '' # if m.__doc__ is None else '"' + m.__doc__ + '"'
      print('   ', m.__name__)

  if print_unimplemented and (methods_unimplemented):
    print('  Unimplemented:')
    for name, member in properties_unimplemented:
      print('   ', name, '-', type(member))
    for m in methods_unimplemented:
      print('   ', m.__name__)

  if print_why_is_this_even_implemented and why_is_this_even_implemented:
    print('  Why do we even have this?')
    for m in why_is_this_even_implemented:
      print('   ', m)

  if print_derived and methods_derived:
    print('  Derived members:')
    for m in methods_derived:
      owner = m.__objclass__.__name__
      print('   ', m.__name__, 'from', owner)

  if print_doc and methods_implemented:
    for m in methods_implemented:
      if not m.__doc__:
        continue

      print(f'  internal static let {m.__name__}Doc = """')
      print(f'    ' + m.__doc__.replace('\n', '\n    '))
      print('    """')
      print()
      print(f'// sourcery: pymethod = {m.__name__}, doc = {m.__name__}Doc')
      print('-' * 80)

  print()
