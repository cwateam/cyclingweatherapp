App.controller('HomeController',['$scope','FirebaseService','MapService', function($scope, FirebaseService, MapService){

    $scope.routeStart = "gustaf hällstömin katu 2, helsinki";
    $scope.routeEnd = "intiankatu 18, helsinki, helsinki";
    $scope.map = MapService.initialize();
    $scope.tempPoints = [];


   // MapService.addMarker($scope.map, 60.1900, 24.9375,2,2);

    $scope.calcRoute = function() {
        MapService.calcRoute($scope.map, $scope.routeStart, $scope.routeEnd);
    }

    $scope.addMarkers = function(){
        var center = $scope.map.getCenter();
        var locations = FirebaseService.getData(center.lat(),center.lng(), 15, function(data){
            MapService.addMarker($scope.map, data.l[0],data.l[1],'C', data.value)

        });
    }

    angular.element(document).ready(function () {
       $scope.addMarkers();
    });

}]);