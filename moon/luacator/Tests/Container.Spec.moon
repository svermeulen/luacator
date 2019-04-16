
Container = require("luacator.Container")
Util = require("luacator.internal.Util")

quxCount = 0

class Qux
  new: =>
    quxCount += 1
  bar: =>

testSingle = ->
  quxCount = 0
  container = Container()
  container\bind('Qux')\toType(Qux)\asSingle!

  Util.assert(quxCount == 0)
  qux = container\resolve('Qux')
  Util.assert(quxCount == 1)
  qux\bar!

  qux2 = container\resolve('Qux')
  Util.assert(quxCount == 1)
  Util.assert(qux == qux2)

testSingleMultipleIds = ->
  quxCount = 0
  container = Container()
  container\bind('Qux', 'Gorp')\toType(Qux)\asSingle!

  Util.assert(quxCount == 0)
  qux = container\resolve('Qux')
  Util.assert(quxCount == 1)
  qux\bar!

  qux2 = container\resolve('Gorp')
  Util.assert(quxCount == 1)
  Util.assert(qux == qux2)

  qux3 = container\resolve('Qux')
  Util.assert(quxCount == 1)
  Util.assert(qux == qux3)

testInstance = ->
  quxCount = 0
  qux = Qux()
  Util.assert(quxCount == 1)

  container = Container()
  container\bind('Qux')\toInstance(qux)

  qux = container\resolve('Qux')
  Util.assert(quxCount == 1)
  qux\bar!

  qux2 = container\resolve('Qux')
  Util.assert(quxCount == 1)
  Util.assert(qux == qux2)

testToModule = ->
  container = Container()
  container\bind('Foo')\toModule('luacator.Tests.Foo')\asSingle!\withArgs('bob', 'joe')

  foo = container\resolve('Foo')
  Util.assert(foo.arg1 == 'bob')
  Util.assert(foo.arg2 == 'joe')

  foo2 = container\resolve('Foo')
  Util.assert(foo2 == foo)

testTransient = ->
  quxCount = 0
  container = Container()
  container\bind('Qux')\toType(Qux)\asTransient!

  Util.assert(quxCount == 0)
  qux = container\resolve('Qux')
  Util.assert(quxCount == 1)
  qux\bar!

  qux2 = container\resolve('Qux')
  Util.assert(quxCount == 2)
  Util.assert(qux != qux2)

testManySingle = ->
  quxCount = 0
  container = Container()
  container\bind('Qux')\toType(Qux)\asSingle!
  container\bind('Qux')\toType(Qux)\asSingle!

  ok, value = pcall(-> container\resolve('Qux'))
  Util.assert(not ok)

  Util.assert(quxCount == 0)
  quxes = container\resolveMany('Qux')
  Util.assert(quxCount == 2)

  Util.assert(#quxes == 2)

  for q in *quxes
    q\bar!

class Gorp
  new: (message) =>
    @message = message

  pho: =>

testSingleArguments = ->
  container = Container()
  container\bind('asdf')\toType(Gorp)\asSingle!\withArgs('test1')

  gorp = container\resolve('asdf')
  Util.assert(gorp.message == 'test1')
  gorp\pho!

testTransientArguments = ->
  container = Container()
  container\bind('asdf')\toType(Gorp)\asTransient!\withArgs('test1')

  gorp = container\resolve('asdf')
  Util.assert(gorp.message == 'test1')
  gorp\pho!

testFactory = ->
  container = Container()
  container\bind('asdf')\toType(Gorp)\asTransient!

  factory = container\resolveFactory('asdf')
  gorp = factory('test1')
  Util.assert(gorp.message == 'test1')
  gorp\pho!

testFactoryModule = ->
  container = Container()
  container\bind('Foo')\toModule('luacator.Tests.Foo')\asTransient!

  fooFactory = container\resolveFactory('Foo')
  foo = fooFactory('bob', 'joe')
  Util.assert(foo.arg1 == 'bob')
  Util.assert(foo.arg2 == 'joe')

testSingle!
testSingleMultipleIds!
testTransient!
testManySingle!
testTransientArguments!
testSingleArguments!
testFactory!
testFactoryModule!

print("Tests passed")

