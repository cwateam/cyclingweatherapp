App.controller('HomeController',['$scope','MapService', function($scope, MapService){

    $scope.routeStart = "gustaf hällstömin katu 2, helsinki";
    $scope.routeEnd = "intiankatu 18, helsinki, helsinki";
    $scope.map = MapService.initialize();

   // MapService.addMarker($scope.map, 60.1900, 24.9375,2,2);

    $scope.calcRoute = function() {
        MapService.calcRoute($scope.map, $scope.routeStart, $scope.routeEnd);
    };

    $scope.clearRoute = function() {
        MapService.clearRoute();
        $scope.routeEnd = "";
        $scope.routeStart = "";
    };

}]);