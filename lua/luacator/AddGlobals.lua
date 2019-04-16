local container = require("luacator.Container")()
do
  local _base_0 = container
  local _fn_0 = _base_0.bind
  Bind = function(...)
    return _fn_0(_base_0, ...)
  end
end
do
  local _base_0 = container
  local _fn_0 = _base_0.resolve
  Resolve = function(...)
    return _fn_0(_base_0, ...)
  end
end
do
  local _base_0 = container
  local _fn_0 = _base_0.resolveFactory
  ResolveFactory = function(...)
    return _fn_0(_base_0, ...)
  end
end
do
  local _base_0 = container
  local _fn_0 = _base_0.resolveManyFactory
  ResolveManyFactory = function(...)
    return _fn_0(_base_0, ...)
  end
end
do
  local _base_0 = container
  local _fn_0 = _base_0.resolveMany
  ResolveMany = function(...)
    return _fn_0(_base_0, ...)
  end
end
do
  local _base_0 = container
  local _fn_0 = _base_0.bindSingleModule
  BindSingleModule = function(...)
    return _fn_0(_base_0, ...)
  end
end
do
  local _base_0 = container
  local _fn_0 = _base_0.bindTransientModule
  BindTransientModule = function(...)
    return _fn_0(_base_0, ...)
  end
end
