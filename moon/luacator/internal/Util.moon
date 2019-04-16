
class Util
  join: (separator, list) ->
    result = ''
    for item in *list
      if #result != 0
        result ..= separator
      result ..= tostring(item)
    return result

  indexOf: (list, item) ->
    for i = 1,#list
      if item == list[i]
        return i

    return -1

  assert: (condition, message) ->
    if not condition
      if message
        error("Assert hit! #{message}")
      else
        error("Assert hit!")

  contains: (list, item) ->
    return Util.indexOf(list, item) != -1

  remove: (list, item) ->
    index = Util.indexOf(list, item)

    if index != -1
      table.remove(list, index)

  try: (t) ->
    success, retValue = xpcall(t.do, debug.traceback)

    if success
      t.finally! if t.finally
      return retValue

    if not t.catch
      t.finally! if t.finally
      -- retValue here will be an Exception object
      error(retValue, 2)

    success, retValue = xpcall((-> t.catch(retValue)), debug.traceback)
    t.finally! if t.finally

    if success
      return retValue

    -- retValue here will be an Exception object
    error(retValue, 2)

