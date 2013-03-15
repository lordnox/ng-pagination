ng-Pagination
=============

[![Build Status](https://travis-ci.org/BinaryMuse/ngInfiniteScroll.png?branch=master)](https://travis-ci.org/BinaryMuse/ngInfiniteScroll)

ng-Pagination is a directive for [AngularJS](http://angularjs.org/) to handle all kinds of pagination for you. It will generate valid html for bootstrap-pagination.

Demos
-----
Check out the demos [in the github repository](https://github.com/lordnox/ng-pagination-examples).

Version Numbers
---------------

ng-Pagination follows [semantic versioning](http://semver.org/) and uses the following versioning scheme:

 * Versions starting with 0 (e.g. 0.1.0, 0.2.0, etc.) are for initial development, and the API is not stable
 * Versions with an even minor version (1.0.0, 1.4.0, 2.2.0, etc.) are stable releases
 * Versions with an odd minor version (1.1.0, 1.3.0, 2.1.0, etc.) are development releases

Getting Started
---------------

 * Download ng-Pagination from [the github repository](https://github.com/lordnox/ng-pagination)
 * Include the script tag on your page after the AngularJS tag (ng-Pagination does not require jQuery to run)

        <script type='text/javascript' src='path/to/angular.min.js'></script>
        <script type='text/javascript' src='path/to/ng-infinite-scroll.min.js'></script>

 * Ensure that your application module specifies `Pagination` as a dependency:

        angular.module('myApplication', ['Pagination']);

 * Use the directive by specifying an `Pagination` attribute on an element.

        <div pagination="data" page="page"></div>

Note that neither the module nor the directive use the `ng` prefix, as that prefix is reserved for the core Angular module.

Detailed Documentation
----------------------

ng-Pagination accepts several attributes to customize the behavior of the directive; detailed instructions will follow here later. If you have questions feel free to open an [issue](https://github.com/lordnox/ng-pagination/issues)

License
-------

ngPagination is licensed under the MIT license. See the LICENSE file for more details.

Testing
-------

ngPagination uses Testacular for its unit tests. Note that you will need [PhantomJS](http://phantomjs.org/) on your path, and the `grunt-cli` npm package installed globally if you wish to use grunt (`npm install -g grunt-cli`). Then, install the dependencies with `npm install`.

 * `grunt test` - continually watch for changes and run tests in PhantomJS and Chrome
 * `npm test` - run tests once in PhantomJS only
