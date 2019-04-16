local TransientProvider = require("luacator.internal.TransientProvider")
local Util = require("luacator.internal.Util")
local SingletonProvider
do
  local _class_0
  local _base_0 = {
    withArgs = function(self, ...)
      return self.provider:withArgs(...)
    end,
    createInstance = function(self, ...)
      local runtimeArgs = {
        ...
      }
      Util.assert(#runtimeArgs == 0, "Cannot have runtime arguments for singletons")
      if not self.instance then
        self.instance = self.provider:createInstance()
        Util.assert(self.instance)
      end
      return self.instance
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, action)
      self.provider = TransientProvider(action)
      self.instance = nil
    end,
    __base = _base_0,
    __name = "SingletonProvider"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  SingletonProvider = _class_0
  return _class_0
end
