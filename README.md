
# Luacator

This is a simple implementation of the service locator pattern, for Lua.

# Usage

Create the container

```lua
container = require("luacator.Container")()
```

Map identifier strings to a factory using fluent interface:

```lua
container:bind('Qux'):toType(Qux):asSingle()
container:bind('Qux'):toInstance(qux)
container:bind('Qux', 'Gorp'):toType(Qux):asSingle()
container:bind('asdf'):toType(Gorp):asTransient()
container:bind('Foo'):toModule('luacator.Tests.Foo'):asSingle():withArgs('bob', 'joe')

-- These work similarly to above but will derive the identifier name from module name
container:bindSingleModule("Things.Foo")
container:bindSingleModule("My.Custom.Directory.Foo", 'Bar', 'Qux')
```

Resolve dependencies:

```lua
qux = container:resolve('Qux')
```

Or resolve the factory itself:

```lua
quxFactory = container:resolveFactory('Qux')
```

Note that in this case it's only useful if it's transient

Note that if you want to use this as service locator pattern you might want to make the container instance global:

```lua
export Container

Container = require("luacator.Container")()
```

Or you could directly expose all the container methods by executing

```lua
require("luacator.AddGlobals")
```

