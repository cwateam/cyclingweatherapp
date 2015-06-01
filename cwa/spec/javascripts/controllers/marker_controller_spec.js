describe('MarkerController', function(){

    var MapServiceMock;
    var FirebaseServiceMock;
    var mapMock;
    var scope, controller, parent;
    var marker;

    beforeEach(function() {
        module('App');

        marker = function(){
            this.map = null;
            return {
                setMap: function(map){
                    this.map = map;
                },
                getMap: function(){
                    return this.map;
                }
            }
        };

        MapServiceMock = (function(){
            return{
                addMarker: function(map,lat, lng, type, value, source, done){
                    var newMarker = new marker;
                    newMarker.setMap(map);
                    done(newMarker);
                }
            }
        })();

        mapMock = map = (function(){
            return {
                getCenter: function(){
                    return {
                        lat: function(){
                            return 60.1900 ;
                        },
                        lng: function(){
                            return 24.9375;
                        }
                    };
                }
            }
        })();

        FirebaseServiceMock = (function () {
            var temperatures = [{
                created: 1432729968365,
                datatype: "temperature",
                g: "us14yfsc92",
                l: [
                    67.99739,
                    24.20946
                ],
                location: "Kittilä Lompolonvuoma",
                mtime: "2015-05-27T12:30:00Z",
                source: "fmi",
                value: "11.2"
            }]

            return {
                getTempData: function(latitude, longitude, radius, done){
                    done(temperatures[0])
                }
            };
        })();

        inject(function($controller, $rootScope) {
            scope = $rootScope.$new();
            scope.$parent.map = mapMock;

            controller = $controller('MarkerController', {
                $scope: scope,
                FirebaseService: FirebaseServiceMock,
                MapService: MapServiceMock
            });
        });
    });

    it('should initially add  marker to fmiMarkers array', function(){
        expect(scope.fmiMarkers.length).toEqual(1);
    });

    it('should set corrrect map for all new markers', function(){
        expect(scope.fmiMarkers[0].getMap()).toEqual(mapMock);
    });


    it('should should hide all the markers when hide temperatures button is pushed', function(){
        scope.hideAllTempMarkers();

        expect(scope.fmiMarkers[0].getMap()).toEqual(null);
    });

    it('should should show all the markers again when hide temperatures button is pushed two times', function(){
        scope.hideAllTempMarkers();
        scope.hideAllTempMarkers();

        expect(scope.fmiMarkers[0].getMap()).toEqual(mapMock);
    });

});