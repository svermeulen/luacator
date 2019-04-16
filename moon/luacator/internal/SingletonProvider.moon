
TransientProvider = require("luacator.internal.TransientProvider")

class SingletonProvider
  new: (action) =>
    @provider = TransientProvider(action)
    @instance = nil

  withArgs: (...) =>
    @provider\withArgs(...)

  createInstance: (...) =>
    runtimeArgs = {...}
    Assert.that(#runtimeArgs == 0, "Cannot have runtime arguments for singletons")

    if not @instance
      @instance = @provider\createInstance()
      Assert.that(@instance)

    return @instance
