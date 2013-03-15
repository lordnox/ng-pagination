lib =
  extend: extend = (options, defaults) ->
    return options  if typeof defaults isnt "object"
    for key of defaults
      options[key] = options[key] or defaults[key]
    options

  range: range = (size) ->
    result = []
    i = 0

    while i < size
      result[i] = i
      i++
    result

  scopeSetter: (scope, attr, defaults) ->
    set = (key, value) ->
      scope[key] = value

    boolean: (key, enable, disable) ->
      return set(key, false)  if attr[disable] isnt undefined
      return set(key, true)  if attr[enable] isnt undefined
      set key, defaults[key]
