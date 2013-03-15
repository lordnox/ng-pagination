"use strict"

paginationTemplate = '<div class="ng-ui-pagination pagination">
  <ul>
    <li ng-show="showPreviousPage" ng-click="setPage(currentPage - 1)" ng-class="{disabled: onFirstPage}">
      <a>&laquo;</a>
    </li>
    <li ng-show="showFirstPage" ng-click="setPage(0)" ng-class="{active: onFirstPage}">
      <a>&laquo; First</a>
    </li>
    <li ng-repeat="page in visiblePages" ng-click="setPage(page.index)" ng-class="{disabled: !page.clickable, active: page.active}">
      <a>{{page.text}}</a>
    </li>
    <li ng-show="showLastPage" ng-click="setPage(maxPages)" ng-class="{active: onLastPage}">
      <a>Last &raquo;</a>
    </li>
    <li ng-show="showNextPage" ng-click="setPage(currentPage + 1)" ng-class="{disabled: onLastPage}">
      <a>&raquo;</a>
    </li>
  </ul>
</div>
'

angular.module("Pagination", [])
  .value('version', '0.0.1')
  .directive("paginationVersion", ['version', (version) ->
    (scope, element) ->
      element.text version
  ])
  .directive "pagination", ->
    defaults =
      padding:
        left: 2
        right: 2
        center: 2

      onFirstPage: true
      onLastPage: true
      showPreviousPage: true
      showFirstPage: true
      showLastPage: true
      showNextPage: true
      pageSize: 10
      currentPage: 0

    directiveDefinitionObject =
      restrict: "EA"
      scope:
        size: "="
        page: "="
        lastPage: "="

      replace: true
      template: paginationTemplate
      compile: (element, attr, linker) ->
        (scope, iterStartElement, attr) ->
          setter = lib.scopeSetter(scope, attr, defaults)
          expression = attr.pagination or attr.paginationResource or attr.resource

          use =
            size: scope.size isnt undefined
            page: scope.page isnt undefined
            lastPage: scope.lastPage isnt undefined

          calcLastPage = ->

            # calculate the last page
            lastPage = Math.ceil(scope.listLength / scope.pageSize)
            scope.maxPages = lastPage - 1
            scope.lastPage = lastPage if use.lastPage

          isVisible = (index) ->

            # decide if we show the first page
            return not scope.showFirstPage  if index is 0

            # decide if we show the last page
            return not scope.showLastPage  if index is scope.maxPages

            # if we are in the left padding...

            # if we are in the right padding...

            # if we are in between the center paddings...
            return true  if index <= scope.padding.left or index >= scope.maxPages - scope.padding.right or Math.abs(index - scope.currentPage) <= scope.padding.center
            false

          update = ->

            # generate an array for each possible page
            scope.pages = lib.range(scope.maxPages + 1)

            # calculate the visible Pages

            # if the page is not visible

            # if the page is not the first one, or the last one, and the page
            # before this is visible...

            # show it anyways if the page afterwards is visible, too
            # to remove any possible gaps

            # else we will show a hellip, see below

            # do not show the page otherwise

            # return just the index if it is visible
            scope.visiblePages = scope.pages.map((index) ->
              unless isVisible(index)
                if index isnt scope.maxPages and index > 1 and isVisible(index - 1)
                  if isVisible(index + 1)
                    return index
                  else
                    return null
                return false
              index
            ).filter((page) ->
              page isnt false
            ).map((element, index) ->

              # any non-number will be a "…" === &hellip;
              # isNaN is not working here, isNaN(null) === false, while it should be true
              if typeof (element) isnt "number"
                return (
                  index: null
                  text: String.fromCharCode(0x2026)
                  clickable: false
                  active: false
                )

              # every number will return an entry for the pagination
              index: element
              text: element + 1
              clickable: true
              active: scope.currentPage is element
            )

            # set the external page
            scope.page = scope.currentPage if use.page

          scope.setPage = (index) ->

            # dont do anything if we are on the right page
            return  if (scope.currentPage is index) or (index is null)

            # correct the page when out of bounds
            scope.currentPage = Math.max(0, Math.min(scope.maxPages, index)) or 0

            # run the update
            update()

            # set these flags
            scope.onFirstPage = scope.currentPage is 0
            scope.onLastPage = scope.currentPage is scope.maxPages


          # watch for chnages of the related list
          scope.$parent.$watch expression, (list) ->

            # set the listLength
            scope.listLength = 0
            scope.listLength = list.length or list if list

            # set the pageSize
            calcLastPage()

            # run the update
            update()


          # register the update function
          scope.$watch "showFirstPage", update
          scope.$watch "showLastPage", update

          # size needs a little extra to set the internal pageSize
          scope.$watch "size", ->
            scope.pageSize = scope.size
            update()


          # page will be routed to the setPage function
          scope.$watch "page", ->
            scope.setPage scope.page

          scope.currentPage = -1
          scope.pageSize = scope.size or scope.pageSize or defaults.pageSize
          scope.size = scope.pageSize if use.size
          scope.currentPage = scope.page or scope.currentPage or defaults.currentPage
          scope.page = scope.currentPage if use.page

          # calculate the listLength once
          scope.listLength = scope.$eval(expression)

          # set default values for padding
          scope.padding = defaults.padding

          # parse user defined input, padding is kind of special
          scope.padding.left = parseInt(attr.paddingLeft, 10) or scope.padding.left
          scope.padding.right = parseInt(attr.paddingRight, 10) or scope.padding.right
          scope.padding.center = parseInt(attr.paddingCenter, 10) or scope.padding.center
          setter.boolean "showPreviousPage", "showPreviousPage", "disablePreviousPage"
          setter.boolean "showFirstPage", "showFirstPage", "disableFirstPage"
          setter.boolean "showLastPage", "showLastPage", "disableLastPage"
          setter.boolean "showNextPage", "showNextPage", "disableNextPage"
          scope.setPage parseInt(attr.currentPage or attr.startPage, 10) or defaults.currentPage

    directiveDefinitionObject
