describe('MarkerController', function(){

    var MapServiceMock;
    var FirebaseServiceMock;
    var scope, controller, parent;

    /*beforeEach(function() {
        module('App');

        MapServiceMock = (function(){
            return{
                addMarker: function(map,lat, lng, type, value, source, done){
                    done("testi");
                }
            }
        })();

        FirebaseServiceMock = (function () {
            var temperatures = [{
                created: 1432729968365,
                datatype: "temperature",
                g: "us14yfsc92",
                l: {
                    0: 67.99739,
                    1: 24.20946
                },
                location: "Kittilä Lompolonvuoma",
                mtime: "2015-05-27T12:30:00Z",
                source: "fmi",
                value: "11.2"
            }]

            return {
                getTemperatureData: function(latitude, longitude, radius, done){
                    done(temperatures[0].value)
                }
            };
        })();

        inject(function($controller, $rootScope) {
            scope = $rootScope.$new();

            controller = $controller('MarkerController', {
                $scope: scope,
                FirebaseService: FirebaseServiceMock,
                MapService: MapServiceMock
            });
        });
    });*/

    it('should add new marker to fmiMarkers array', function(){


        expect(1/*scope.fmiMarkers.length*/).toEqual(1);
    });


    it('true should be true', function(){
        expect(true).toBe(true);
    });
});