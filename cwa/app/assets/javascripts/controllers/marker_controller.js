App.controller('MarkerController',['$scope','FirebaseService','MapService', function($scope, FirebaseService, MapService) {

    $scope.tempPoints = [];
    $scope.fmiMarkers = [];


    $scope.addTemperatureMarkers = function(){
        var center = $scope.$parent.map.getCenter();
        var locations = FirebaseService.getTempData(center.lat(),center.lng(), 25, function(data){
        MapService.addMarker($scope.$parent.map, data.l[0],data.l[1],'C', data.value, data.source, function(data){
                if(data.source === "fmi" || !data.source) {
                    $scope.fmiMarkers.push(data);
                } else {
                    console.log(data);
                    $scope.tempPoints.push(data);
                }
            })

        });
    };

    $scope.hideFmiMarkers = function(){
        for (var i = 0; i < $scope.fmiMarkers.length; i++){

            var marker =  $scope.fmiMarkers[i];

            if(!marker.getMap()){
                marker.setMap($scope.$parent.map);
            } else {
                marker.setMap(null)
            }
        }
    }

    angular.element(document).ready(function () {
        $scope.addTemperatureMarkers();
    });

}]);