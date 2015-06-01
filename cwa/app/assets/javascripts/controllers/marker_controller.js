App.controller('MarkerController',['$scope','FirebaseService','MapService', function($scope, FirebaseService, MapService) {

    $scope.tempPoints = [];
    $scope.fmiMarkers = [];


    $scope.addTemperatureMarkers = function(){
        var center = $scope.$parent.map.getCenter();
        var i = 0;
        var locations = FirebaseService.getTempData(center.lat(),center.lng(), 25, function(data){
        MapService.addMarker($scope.$parent.map, data.l[0],data.l[1],'C', data.value, data.source, function(data){
                if(data.source === "fmi" || !data.source) {
                    $scope.fmiMarkers.push(data);
                } else {
                    $scope.tempPoints.push(data);
                };
            });

        });
    };

    $scope.hideAllTempMarkers = function(){
        hideTempMarkers($scope.fmiMarkers, $scope.$parent.map);
        hideTempMarkers($scope.tempPoints, $scope.$parent.map);
    };

    hideTempMarkers = function(markers, map){
        for (var i = 0; i < markers.length; i++){
            var marker =  markers[i];
            if(!marker.getMap()){
                marker.setMap(map);
            } else {
                marker.setMap(null);
            };
        };
    };

    angular.element(document).ready(function () {
        $scope.addTemperatureMarkers();
    });

}]);