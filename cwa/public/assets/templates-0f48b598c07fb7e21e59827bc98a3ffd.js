// Angular Rails Template
// source: app/assets/javascripts/templates/index.html

angular.module("templates").run(["$templateCache", function($templateCache) {
  $templateCache.put("index.html", '<div id="content">\n\n    <nav class="navbar navbar-default navbar-fixed-top">\n        <div class="container-fluid">\n            <div class="navbar-header">\n                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">\n                    <span class="sr-only">Toggle navigation</span>\n                    <span class="icon-bar"></span>\n                    <span class="icon-bar"></span>\n                    <span class="icon-bar"></span>\n                </button>\n                <a class="navbar-brand" href="/">CWA</a>\n            </div>\n            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">\n\n                    <form  class="navbar-form navbar-left" role="form" id="routingForm">\n                      <div class="form-group">\n                            <input type="text" ng-model="routeStart" name="origin"  class="form-control" placeholder="Origin">\n                            <input type="text" ng-model="routeEnd" name="destination" class="form-control" placeholder="Destination">\n                      </div>\n                        <button ng-click="calcRoute()" class="btn btn-default btn-info">Route</button>\n                    </form>\n\n                <div class="btn-group" data-toggle="buttons">\n                    <label class="btn btn-warning navbar-btn big-icon big-icon-padding">\n                        <input type="button" value="particulates" ><span class="glyphicon glyphicon-asterisk"></span>\n                    </label>\n                    <label class="btn btn-warning navbar-btn big-icon big-icon-padding">\n                        <input type="button"  value="temperature"  id="temperature"><span class="glyphicon glyphicon-dashboard"></span>\n                    </label>\n                </div>\n                <button type="button" class="btn btn-default btn-info big-icon big-icon-padding" data-placement="bottom" data-toggle="popover">\n                    <span class="glyphicon glyphicon-question-sign"></span>\n                </button>\n            </div>\n        </div>\n    </nav>\n\n        <div class="container-map">\n            <div ng-model="map"id="map_canvas"></div>\n            <div class="temperature" id="weather"></div>\n        </div>\n\n    <div id="popover_content_wrapper" style="display: none">\n        <div>\n            <p>\n                <span class="glyphicon glyphicon-asterisk big-icon"></span> Particulates visualization\n            </p>\n            <p>\n                <span class="glyphicon glyphicon-dashboard big-icon"></span> Temperature visualization\n            </p>\n        </div>\n\n\n    </div>\n</div>')
}]);
