
ScopeBinder = require("luacator.ScopeBinder")

class FromBinder
  new: (container, identifiers) =>
    @identifiers = identifiers
    @container = container

  toInstance: (obj) =>
    return ScopeBinder(@container, @identifiers, -> obj)

  toType: (objType) =>
    Assert.that(type(objType) == 'table')
    return ScopeBinder(@container, @identifiers, objType)

  toModule: (moduleName) =>
    Assert.that(type(moduleName) == 'string')
    return ScopeBinder @container, @identifiers, (...) ->
      runtimeArgs = {...}
      module = require(moduleName)
      result = nil
      Ave.Try
        do: ->
          result = module(unpack(runtimeArgs))
        catch: (e) ->
          -- Add some extra info
          error("Error while loading module '#{moduleName}': #{e}")
      return result

