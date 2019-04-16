local Util = require("luacator.internal.Util")
local unpack = table.unpack or unpack
local TransientProvider
do
  local _class_0
  local _base_0 = {
    withArgs = function(self, ...)
      Util.assert(#self.staticArgs == 0)
      self.staticArgs = {
        ...
      }
    end,
    createInstance = function(self, ...)
      local runtimeArgs = {
        ...
      }
      local allArgs = { }
      local _list_0 = self.staticArgs
      for _index_0 = 1, #_list_0 do
        local arg = _list_0[_index_0]
        table.insert(allArgs, arg)
      end
      for _index_0 = 1, #runtimeArgs do
        local arg = runtimeArgs[_index_0]
        table.insert(allArgs, arg)
      end
      return self.action(unpack(allArgs))
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, action)
      self.action = action
      self.staticArgs = { }
    end,
    __base = _base_0,
    __name = "TransientProvider"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  TransientProvider = _class_0
  return _class_0
end
