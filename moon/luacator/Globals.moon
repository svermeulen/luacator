
export Resolve, ResolveMany, ResolveFactory, ResolveManyFactory, Bind

container = require("luacator.Container")()

Bind = container\bind
Resolve = container\resolve
ResolveFactory = container\resolveFactory
ResolveManyFactory = container\resolveManyFactory
ResolveMany = container\resolveMany

