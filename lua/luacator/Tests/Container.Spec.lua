local Container = require("luacator.Container")
local quxCount = 0
local Qux
do
  local _class_0
  local _base_0 = {
    bar = function(self) end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      quxCount = quxCount + 1
    end,
    __base = _base_0,
    __name = "Qux"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Qux = _class_0
end
local testSingle
testSingle = function()
  quxCount = 0
  local container = Container()
  container:bind('Qux'):toType(Qux):asSingle()
  Assert.that(quxCount == 0)
  local qux = container:resolve('Qux')
  Assert.that(quxCount == 1)
  qux:bar()
  local qux2 = container:resolve('Qux')
  Assert.that(quxCount == 1)
  return Assert.isEqual(qux, qux2)
end
local testSingleMultipleIds
testSingleMultipleIds = function()
  quxCount = 0
  local container = Container()
  container:bind('Qux', 'Gorp'):toType(Qux):asSingle()
  Assert.that(quxCount == 0)
  local qux = container:resolve('Qux')
  Assert.that(quxCount == 1)
  qux:bar()
  local qux2 = container:resolve('Gorp')
  Assert.that(quxCount == 1)
  Assert.isEqual(qux, qux2)
  local qux3 = container:resolve('Qux')
  Assert.that(quxCount == 1)
  return Assert.isEqual(qux, qux3)
end
local testInstance
testInstance = function()
  quxCount = 0
  local qux = Qux()
  Assert.that(quxCount == 1)
  local container = Container()
  container:bind('Qux'):toInstance(qux)
  qux = container:resolve('Qux')
  Assert.that(quxCount == 1)
  qux:bar()
  local qux2 = container:resolve('Qux')
  Assert.that(quxCount == 1)
  return Assert.isEqual(qux, qux2)
end
local testToModule
testToModule = function()
  local container = Container()
  container:bind('Foo'):toModule('luacator.Tests.Foo'):asSingle():withArgs('bob', 'joe')
  local foo = container:resolve('Foo')
  Assert.that(foo.arg1 == 'bob')
  Assert.that(foo.arg2 == 'joe')
  local foo2 = container:resolve('Foo')
  return Assert.isEqual(foo2, foo)
end
local testTransient
testTransient = function()
  quxCount = 0
  local container = Container()
  container:bind('Qux'):toType(Qux):asTransient()
  Assert.that(quxCount == 0)
  local qux = container:resolve('Qux')
  Assert.that(quxCount == 1)
  qux:bar()
  local qux2 = container:resolve('Qux')
  Assert.that(quxCount == 2)
  return Assert.isNotEqual(qux, qux2)
end
local testManySingle
testManySingle = function()
  quxCount = 0
  local container = Container()
  container:bind('Qux'):toType(Qux):asSingle()
  container:bind('Qux'):toType(Qux):asSingle()
  Assert.throws(function()
    return container:resolve('Qux')
  end)
  Assert.that(quxCount == 0)
  local quxes = container:resolveMany('Qux')
  Assert.that(quxCount == 2)
  Assert.isEqual(#quxes, 2)
  for _index_0 = 1, #quxes do
    local q = quxes[_index_0]
    q:bar()
  end
end
local Gorp
do
  local _class_0
  local _base_0 = {
    pho = function(self) end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, message)
      self.message = message
    end,
    __base = _base_0,
    __name = "Gorp"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Gorp = _class_0
end
local testSingleArguments
testSingleArguments = function()
  local container = Container()
  container:bind('asdf'):toType(Gorp):asSingle():withArgs('test1')
  local gorp = container:resolve('asdf')
  Assert.isEqual(gorp.message, 'test1')
  return gorp:pho()
end
local testTransientArguments
testTransientArguments = function()
  local container = Container()
  container:bind('asdf'):toType(Gorp):asTransient():withArgs('test1')
  local gorp = container:resolve('asdf')
  Assert.isEqual(gorp.message, 'test1')
  return gorp:pho()
end
local testFactory
testFactory = function()
  local container = Container()
  container:bind('asdf'):toType(Gorp):asTransient()
  local factory = container:resolveFactory('asdf')
  local gorp = factory('test1')
  Assert.isEqual(gorp.message, 'test1')
  return gorp:pho()
end
local testFactoryModule
testFactoryModule = function()
  local container = Container()
  container:bind('Foo'):toModule('luacator.Tests.Foo'):asTransient()
  local fooFactory = container:resolveFactory('Foo')
  local foo = fooFactory('bob', 'joe')
  Assert.that(foo.arg1 == 'bob')
  return Assert.that(foo.arg2 == 'joe')
end
testSingle()
testSingleMultipleIds()
testTransient()
testManySingle()
testTransientArguments()
testSingleArguments()
testFactory()
testFactoryModule()
return print("Tests passed")
