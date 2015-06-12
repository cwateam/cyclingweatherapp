describe('BikeOverlayController', function(){


    beforeEach(function() {
        inject(function($controller, $rootScope) {
            scope = $rootScope.$new();
            controller = $controller('BikeOverlayController', {
                $scope: scope,
            });
        });
    });

    it('should initially have map set up corretly', inject(function(MapService){

        scope.$parent.map = MapService.initialize();
        expect(MapService.getBicycleOverlay().getMap()).toEqual(scope.$parent.map);
    }));

    it('should hide bike overlay when toggle bike overay button is pushed', inject(function(MapService){
        var map = MapService.initialize();
        scope.toggleBikeOverlay(map);
        expect(MapService.getBicycleOverlay().getMap()).toEqual(null);
    }));


});