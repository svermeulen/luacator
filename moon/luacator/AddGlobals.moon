
export Resolve, ResolveMany, ResolveFactory, ResolveManyFactory, Bind, BindTransientModule, BindSingleModule

container = require("luacator.Container")()

Bind = container\bind
Resolve = container\resolve
ResolveFactory = container\resolveFactory
ResolveManyFactory = container\resolveManyFactory
ResolveMany = container\resolveMany
BindSingleModule = container\bindSingleModule
BindTransientModule = container\bindTransientModule

