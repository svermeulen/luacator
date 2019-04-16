
TransientProvider = require("luacator.internal.TransientProvider")
Util = require("luacator.internal.Util")

class SingletonProvider
  new: (action) =>
    @provider = TransientProvider(action)
    @instance = nil

  withArgs: (...) =>
    @provider\withArgs(...)

  createInstance: (...) =>
    runtimeArgs = {...}
    Util.assert(#runtimeArgs == 0, "Cannot have runtime arguments for singletons")

    if not @instance
      @instance = @provider\createInstance()
      Util.assert(@instance)

    return @instance
