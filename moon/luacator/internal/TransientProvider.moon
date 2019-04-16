Util = require("luacator.internal.Util")

class TransientProvider
  new: (action) =>
    @action = action
    @staticArgs = {}

  withArgs: (...) =>
    Util.assert(#@staticArgs == 0)
    @staticArgs = {...}

  createInstance: (...) =>
    runtimeArgs = {...}
    allArgs = {}

    for arg in *@staticArgs
      table.insert(allArgs, arg)

    for arg in *runtimeArgs
      table.insert(allArgs, arg)

    return @.action(Util.unpack(allArgs))
