local ScopeBinder = require("luacator.internal.ScopeBinder")
local Util = require("luacator.internal.Util")
local FromBinder
do
  local _class_0
  local _base_0 = {
    toInstance = function(self, obj)
      return ScopeBinder(self.container, self.identifiers, function()
        return obj
      end)
    end,
    toType = function(self, objType)
      Assert.that(type(objType) == 'table')
      return ScopeBinder(self.container, self.identifiers, objType)
    end,
    toModule = function(self, moduleName)
      Assert.that(type(moduleName) == 'string')
      return ScopeBinder(self.container, self.identifiers, function(...)
        local runtimeArgs = {
          ...
        }
        local module = require(moduleName)
        local result = nil
        Util.try({
          ["do"] = function()
            result = module(unpack(runtimeArgs))
          end,
          catch = function(e)
            return error("Error while loading module '" .. tostring(moduleName) .. "': " .. tostring(e))
          end
        })
        return result
      end)
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, container, identifiers)
      self.identifiers = identifiers
      self.container = container
    end,
    __base = _base_0,
    __name = "FromBinder"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  FromBinder = _class_0
  return _class_0
end
