
Container = require("luacator.Container")

quxCount = 0

class Qux
  new: =>
    quxCount += 1
  bar: =>

testSingle = ->
  quxCount = 0
  container = Container()
  container\bind('Qux')\toType(Qux)\asSingle!

  Assert.that(quxCount == 0)
  qux = container\resolve('Qux')
  Assert.that(quxCount == 1)
  qux\bar!

  qux2 = container\resolve('Qux')
  Assert.that(quxCount == 1)
  Assert.isEqual(qux, qux2)

testSingleMultipleIds = ->
  quxCount = 0
  container = Container()
  container\bind('Qux', 'Gorp')\toType(Qux)\asSingle!

  Assert.that(quxCount == 0)
  qux = container\resolve('Qux')
  Assert.that(quxCount == 1)
  qux\bar!

  qux2 = container\resolve('Gorp')
  Assert.that(quxCount == 1)
  Assert.isEqual(qux, qux2)

  qux3 = container\resolve('Qux')
  Assert.that(quxCount == 1)
  Assert.isEqual(qux, qux3)

testInstance = ->
  quxCount = 0
  qux = Qux()
  Assert.that(quxCount == 1)

  container = Container()
  container\bind('Qux')\toInstance(qux)

  qux = container\resolve('Qux')
  Assert.that(quxCount == 1)
  qux\bar!

  qux2 = container\resolve('Qux')
  Assert.that(quxCount == 1)
  Assert.isEqual(qux, qux2)

testToModule = ->
  container = Container()
  container\bind('Foo')\toModule('Ave.Ioc.Tests.Foo')\asSingle!\withArgs('bob', 'joe')

  foo = container\resolve('Foo')
  Assert.that(foo.arg1 == 'bob')
  Assert.that(foo.arg2 == 'joe')

  foo2 = container\resolve('Foo')
  Assert.isEqual(foo2, foo)

testTransient = ->
  quxCount = 0
  container = Container()
  container\bind('Qux')\toType(Qux)\asTransient!

  Assert.that(quxCount == 0)
  qux = container\resolve('Qux')
  Assert.that(quxCount == 1)
  qux\bar!

  qux2 = container\resolve('Qux')
  Assert.that(quxCount == 2)
  Assert.isNotEqual(qux, qux2)

testManySingle = ->
  quxCount = 0
  container = Container()
  container\bind('Qux')\toType(Qux)\asSingle!
  container\bind('Qux')\toType(Qux)\asSingle!

  Assert.throws(-> container\resolve('Qux'))

  Assert.that(quxCount == 0)
  quxes = container\resolveMany('Qux')
  Assert.that(quxCount == 2)

  Assert.isEqual(#quxes, 2)

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
  Assert.isEqual(gorp.message, 'test1')
  gorp\pho!

testTransientArguments = ->
  container = Container()
  container\bind('asdf')\toType(Gorp)\asTransient!\withArgs('test1')

  gorp = container\resolve('asdf')
  Assert.isEqual(gorp.message, 'test1')
  gorp\pho!

testFactory = ->
  container = Container()
  container\bind('asdf')\toType(Gorp)\asTransient!

  factory = container\resolveFactory('asdf')
  gorp = factory('test1')
  Assert.isEqual(gorp.message, 'test1')
  gorp\pho!

testFactoryModule = ->
  container = Container()
  container\bind('Foo')\toModule('Ave.Ioc.Tests.Foo')\asTransient!

  fooFactory = container\resolveFactory('Foo')
  foo = fooFactory('bob', 'joe')
  Assert.that(foo.arg1 == 'bob')
  Assert.that(foo.arg2 == 'joe')

testSingle!
testSingleMultipleIds!
testTransient!
testManySingle!
testTransientArguments!
testSingleArguments!
testFactory!
testFactoryModule!

print("Tests passed")

