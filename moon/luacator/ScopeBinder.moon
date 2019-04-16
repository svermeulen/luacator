
TransientProvider = require("luacator.TransientProvider")
SingletonProvider = require("luacator.SingletonProvider")

class ScopeBinder
  new: (container, identifiers, factory) =>
    @container = container
    @factory = factory
    @identifiers = identifiers

  asSingle: =>
    binder = SingletonProvider(@factory)
    for identifier in *@identifiers
      @container\registerProvider(identifier, binder)
    return binder

  asTransient:  =>
    binder = TransientProvider(@factory)
    for identifier in *@identifiers
      @container\registerProvider(identifier, binder)
    return binder

