describe('BikeOverlayController', function(){


    beforeEach(function() {
        inject(function($controller, $rootScope) {
            scope = $rootScope.$new();
            scope.$parent.map = mapMock;

            controller = $controller('BikeOverlayController', {
                $scope: scope,
                MapService: MapServiceMock
            });
        });
    });

    it('should initially have map set up corretly', function(){
       expect(bicycleOverlay).toEqual(mapMock);
    });

    it('should hide bike overlay when toggle bike overay button is pushed', function(){
        scope.toggleBikeOverlay(scope.$parent.map);
        expect(bicycleOverlay).toEqual(null);
    });


});