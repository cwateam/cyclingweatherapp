describe('HomeController', function() {


    beforeEach(function () {
        inject(function ($controller, $rootScope, MapService) {
            scope = $rootScope.$new();
            controller = $controller('HomeController', {
                $scope: scope,
                MapService: MapService,
            });
        });
    });

    it("should clear original route end and start when clear route button is pushed", function(){
        scope.clearRoute();
        expect(scope.routeStart).toEqual("");
        expect(scope.routeEnd).toEqual("");
    });

    it("should clear route from map when clear button is pushed", function(){
        scope.routeStart = "Helsinki";
        scope.routeEnd = "Turku";
        scope.calcRoute();
        scope.clearRoute();
        expect(directionsDisplayMap).toEqual(null);
        expect(directionsDisplayPanel).toEqual(null);

    });

    it("should show route when route button is pushed with valid parameters", function(){
        scope.routeStart = "Helsinki";
        scope.routeEnd = "Turku";
        scope.calcRoute();
        expect(directionsDisplayMap).toEqual(scope.map);
        expect(directions).toEqual({
            origin: scope.routeStart,
            destination: scope.routeEnd,
            travelMode: google.maps.TravelMode.BICYCLING
        });

    });
});