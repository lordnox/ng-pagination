"use strict"

angular
  .module("Pagination")
  .filter("pagination", ->
    (input, page, size) ->
      input.slice page * size, (page + 1) * size
  )
  .filter("pageSlice", ->
    (input, args...) ->
      Array::slice.apply input, args
  )
