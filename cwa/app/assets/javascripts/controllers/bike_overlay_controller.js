App.controller('BikeOverlayController',['$scope','MapService', function($scope, MapService){


    $scope.toggleBikeOverlay = function(){
        MapService.toggleBikeOverlay($scope.$parent.map);
    };

}]);