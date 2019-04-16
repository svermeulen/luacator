local TransientProvider = require("luacator.internal.TransientProvider")
local SingletonProvider = require("luacator.internal.SingletonProvider")
local ScopeBinder
do
  local _class_0
  local _base_0 = {
    asSingle = function(self)
      local binder = SingletonProvider(self.factory)
      local _list_0 = self.identifiers
      for _index_0 = 1, #_list_0 do
        local identifier = _list_0[_index_0]
        self.container:registerProvider(identifier, binder)
      end
      return binder
    end,
    asTransient = function(self)
      local binder = TransientProvider(self.factory)
      local _list_0 = self.identifiers
      for _index_0 = 1, #_list_0 do
        local identifier = _list_0[_index_0]
        self.container:registerProvider(identifier, binder)
      end
      return binder
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, container, identifiers, factory)
      self.container = container
      self.factory = factory
      self.identifiers = identifiers
    end,
    __base = _base_0,
    __name = "ScopeBinder"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  ScopeBinder = _class_0
  return _class_0
end
