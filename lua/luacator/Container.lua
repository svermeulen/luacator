local FromBinder = require("luacator.internal.FromBinder")
local Util = require("luacator.internal.Util")
local Container
do
  local _class_0
  local _base_0 = {
    _parseNameFromModule = function(self, moduleName)
      return moduleName:match('%.([^%.]*)$')
    end,
    bindSingleModule = function(self, moduleName, ...)
      local ids = {
        ...
      }
      table.insert(ids, self:_parseNameFromModule(moduleName))
      return self:bind(unpack(ids)):toModule(moduleName):asSingle()
    end,
    bindTransientModule = function(self, moduleName, ...)
      local ids = {
        ...
      }
      table.insert(ids, self:_parseNameFromModule(moduleName))
      return self:bind(unpack(ids)):toModule(moduleName):asTransient()
    end,
    bind = function(self, ...)
      Util.assert(not self.startedBinding)
      self.startedBinding = true
      return FromBinder(self, {
        ...
      })
    end,
    hasBinding = function(self, identifier)
      return self.providerLists[identifier] ~= nil
    end,
    _getObjectGraph = function(self)
      return Util.join(' -> ', self.identifierLookupsInProgress)
    end,
    _processProvider = function(self, provider, asFactory)
      local factory
      do
        local _base_1 = provider
        local _fn_0 = _base_1.createInstance
        factory = function(...)
          return _fn_0(_base_1, ...)
        end
      end
      if asFactory then
        return factory
      end
      return factory()
    end,
    _resolveInternal = function(self, identifier, matchMany, asFactory)
      Util.assert(not Util.contains(self.identifierLookupsInProgress, identifier), "Found circular dependency!  Object graph: " .. tostring(self:_getObjectGraph()) .. " -> " .. tostring(identifier))
      table.insert(self.identifierLookupsInProgress, identifier)
      return Util.try({
        ["do"] = function()
          local providers = self.providerLists[identifier]
          if matchMany then
            if not providers then
              return { }
            end
            local _accum_0 = { }
            local _len_0 = 1
            for _index_0 = 1, #providers do
              local x = providers[_index_0]
              _accum_0[_len_0] = self:_processProvider(x, asFactory)
              _len_0 = _len_0 + 1
            end
            return _accum_0
          end
          Util.assert(providers, "Could not find dependency with identifier '" .. tostring(identifier) .. "'")
          Util.assert(#providers == 1, "Found multiple providers when only one was expected for identifier '" .. tostring(identifier) .. "'")
          return self:_processProvider(providers[1], asFactory)
        end,
        finally = function()
          return Util.remove(self.identifierLookupsInProgress, identifier)
        end
      })
    end,
    resolveFactory = function(self, identifier)
      return self:_resolveInternal(identifier, false, true)
    end,
    resolveManyFactory = function(self, identifier)
      return self:_resolveInternal(identifier, true, true)
    end,
    resolve = function(self, identifier)
      return self:_resolveInternal(identifier, false, false)
    end,
    resolveMany = function(self, identifier)
      return self:_resolveInternal(identifier, true, false)
    end,
    registerProvider = function(self, identifier, provider)
      self.startedBinding = false
      Util.assert(identifier)
      local providers = self.providerLists[identifier]
      if not providers then
        providers = { }
        self.providerLists[identifier] = providers
      end
      return table.insert(providers, provider)
    end,
    clear = function(self)
      self.providerLists = { }
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      self.providerLists = { }
      self.startedBinding = false
      self.identifierLookupsInProgress = { }
    end,
    __base = _base_0,
    __name = "Container"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Container = _class_0
  return _class_0
end
