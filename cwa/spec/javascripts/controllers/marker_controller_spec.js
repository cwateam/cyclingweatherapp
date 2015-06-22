//describe('MarkerController', function(){
//
//    beforeEach(function() {
//
//        inject(function($controller, $rootScope, MapService) {
//            scope = $rootScope.$new();
//            scope.$parent.map = MapService.initialize();
//
//            controller = $controller('MarkerController', {
//                $scope: scope,
//                FirebaseService: FirebaseServiceMock,
//                MapService: MapService
//            });
//        });
//    });
//
//    it('should initially add  marker to fmiMarkers array', inject(function(MapService){
//
//        expect(scope.fmiMarkers.length).toEqual(1);
//    }));
//
//    it('should set corrrect map for all new markers', function(){
//        expect(scope.fmiMarkers[0].getMap()).toEqual(scope.$parent.map);
//    });
//
//
//    it('should should hide all the markers when hide temperatures button is pushed', function(){
//        scope.hideAllTempMarkers();
//
//        expect(scope.fmiMarkers[0].getMap()).toEqual(null);
//    });
//
//    it('should should show all the markers again when hide temperatures button is pushed two times', function(){
//        scope.hideAllTempMarkers();
//        scope.hideAllTempMarkers();
//
//        expect(scope.fmiMarkers[0].getMap()).toEqual(scope.$parent.map);
//    });
//
//});