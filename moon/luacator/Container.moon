
FromBinder = require("luacator.internal.FromBinder")
Util = require("luacator.internal.Util")

class Container
  new: =>
    @providerLists = {}
    @startedBinding = false
    @identifierLookupsInProgress = {}

  bind: (...) =>
    Assert.that(not @startedBinding)
    @startedBinding = true
    return FromBinder(@, {...})

  hasBinding: (identifier) =>
    return @providerLists[identifier] != nil

  _getObjectGraph: =>
    return Util.join(' -> ', @identifierLookupsInProgress)

  _processProvider: (provider, asFactory) =>
    factory = provider\createInstance

    if asFactory
      return factory

    return factory!

  _resolveInternal: (identifier, matchMany, asFactory) =>
    Assert.that(not Util.contains(@identifierLookupsInProgress, identifier),
      "Found circular dependency!  Object graph: #{@\_getObjectGraph!} -> #{identifier}")

    table.insert(@identifierLookupsInProgress, identifier)

    return Util.try
      do: ->
        providers = @providerLists[identifier]

        if matchMany
          if not providers
            return {}

          return [@\_processProvider(x, asFactory) for x in *providers]

        Assert.that(providers,
          "Could not find dependency with identifier '#{identifier}'")

        Assert.that(#providers == 1,
          "Found multiple providers when only one was expected for identifier '#{identifier}'")

        return @\_processProvider(providers[1], asFactory)

      finally: ->
        Util.remove(@identifierLookupsInProgress, identifier)

  resolveFactory: (identifier) =>
    @\_resolveInternal(identifier, false, true)

  resolveManyFactory: (identifier) =>
    @\_resolveInternal(identifier, true, true)

  resolve: (identifier) =>
    @\_resolveInternal(identifier, false, false)

  resolveMany: (identifier) =>
    @\_resolveInternal(identifier, true, false)

  registerProvider: (identifier, provider) =>
    -- Ignore this in case the binding calls it multiple times
    --Assert.that(@startedBinding)
    @startedBinding = false
    Assert.that(identifier)

    providers = @providerLists[identifier]

    if not providers
      providers = {}
      @providerLists[identifier] = providers

    table.insert(providers, provider)

  clear: =>
    @providerLists = {}

