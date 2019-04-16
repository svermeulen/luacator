local Util
do
  local _class_0
  local _base_0 = {
    join = function(separator, list)
      local result = ''
      for _index_0 = 1, #list do
        local item = list[_index_0]
        if #result ~= 0 then
          result = result .. separator
        end
        result = result .. tostring(item)
      end
      return result
    end,
    indexOf = function(list, item)
      for i = 1, #list do
        if item == list[i] then
          return i
        end
      end
      return -1
    end,
    unpack = table.unpack or unpack,
    assert = function(condition, message)
      if not condition then
        if message then
          return error("Assert hit! " .. tostring(message))
        else
          return error("Assert hit!")
        end
      end
    end,
    contains = function(list, item)
      return Util.indexOf(list, item) ~= -1
    end,
    remove = function(list, item)
      local index = Util.indexOf(list, item)
      if index ~= -1 then
        return table.remove(list, index)
      end
    end,
    try = function(t)
      local success, retValue = xpcall(t["do"], debug.traceback)
      if success then
        if t.finally then
          t.finally()
        end
        return retValue
      end
      if not t.catch then
        if t.finally then
          t.finally()
        end
        error(retValue, 2)
      end
      success, retValue = xpcall((function()
        return t.catch(retValue)
      end), debug.traceback)
      if t.finally then
        t.finally()
      end
      if success then
        return retValue
      end
      return error(retValue, 2)
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function() end,
    __base = _base_0,
    __name = "Util"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Util = _class_0
  return _class_0
end
