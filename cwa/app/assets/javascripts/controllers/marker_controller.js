App.controller('MarkerController',['$scope','FirebaseService','MapService', function($scope, FirebaseService, MapService) {

    $scope.tempPoints = [];
    $scope.fmiMarkers = [];


    $scope.addTemperatureMarkers = function(){
        var center = $scope.$parent.map.getCenter();
        var locations = FirebaseService.getTempData(center.lat(),center.lng(), 15, function(data){
            console.log(data)
            var marker = MapService.addMarker($scope.$parent.map, data.l[0],data.l[1],'C', data.value, data.source, function(data){
                if(data.source === "fmi" || !data.source) {

                    $scope.fmiMarkers.push(data);
                } else {
                    $scope.tempPoints.push(data);

                }
            })

        });

    };

    $scope.hideFmiMarkers = function(){
        console.log("asdas")
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