class MyObject:
    pass

assert not MyObject() == MyObject()
assert MyObject() != MyObject()
myobj = MyObject()
assert myobj == myobj
assert not myobj != myobj

object.__subclasshook__()
object.__subclasshook__() == NotImplemented
object.__subclasshook__(1) == NotImplemented
object.__subclasshook__(1, 2) == NotImplemented

assert MyObject().__eq__(MyObject()) == NotImplemented
assert MyObject().__ne__(MyObject()) == NotImplemented
assert MyObject().__lt__(MyObject()) == NotImplemented
assert MyObject().__le__(MyObject()) == NotImplemented
assert MyObject().__gt__(MyObject()) == NotImplemented
assert MyObject().__ge__(MyObject()) == NotImplemented

obj = MyObject()
assert not hasattr(obj, 'a')
obj.__dict__ = {'a': 1}
assert obj.a == 1

del obj.__dict__
assert obj.__dict__ == { }
