should = chai.should()

describe 'Pagination', ->
  [$rootScope, $compile, docWindow, $document, $timeout, fakeWindow, origJq] = [undefined]

  beforeEach ->
    module 'Pagination'

  beforeEach ->
    inject (_$rootScope_, _$compile_, _$window_, _$document_, _$timeout_) ->
      $rootScope  = _$rootScope_
      $compile    = _$compile_
      $window     = _$window_
      $document   = _$document_
      $timeout    = _$timeout_
      fakeWindow  = angular.element $window
      origJq      = angular.element

      angular.element = (first, args...) ->
        if first == $window
          fakeWindow
        else
          origJq first, args...

  afterEach ->
    angular.element = origJq

  it 'respects the infinite-scroll-distance attribute', ->
    tpl = '<div pagination="test.pages" page="test.page" size="1" disable-last-page disable-first-page></div>'

    element = angular.element tpl
    $document.append element
    scope   = $rootScope.$new(true)
    scope.test =
      page: 0
      pages: [
        {text: 'Page 1'}
        {text: 'Page 2'}
        {text: 'Page 3'}
      ]


    $compile(element)(scope)
    scope.$digest()

    console.log element[0].outerHTML

    element.remove()
    scope.$destroy()

