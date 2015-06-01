var MapServiceMock;
var FirebaseServiceMock;
var mapMock;
var scope, controller, parent;
var marker, bicycleOverlay;


beforeEach(function(){
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

    MapServiceMock = (function(){
         bicycleOverlay = mapMock;
        return{
            addMarker: function(map,lat, lng, type, value, source, done){
                var newMarker = new marker;
                newMarker.setMap(map);
                done(newMarker);
            },
            toggleBikeOverlay: function(map){
                if (bicycleOverlay !== null){
                    bicycleOverlay = null;
                } else {
                    bicycleOverlay = map;
                }

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
});