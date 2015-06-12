var MapServiceMock;
var FirebaseServiceMock;
var mapMock;
var scope, controller, parent;
var marker;
var google = {};


beforeEach(function(){

    module('App');


    //Mock for google.maps API
    google = {

        maps: {
            Map : function(element, mapOptions){
                var center = mapOptions.center;
                return {
                    options : mapOptions,
                    element : element,
                    getCenter: function(){
                        return center
                    }
                }
            },
            DirectionStatus: {
                OK: "ok"
            },

            DirectionsService: function(){
                return {
                }
            },

            BicyclingLayer: function(){
                var map;
                return {
                    setMap: function(newMap){
                        map = newMap;
                    },
                    getMap: function(){
                        return map;
                    }
                }
            },

            DirectionsRenderer: function(){
                var panel;
                var map;
                var directions;
                return {
                    setPanel: function(paneel){
                    panel = paneel;
                },
                    setMap : function(maap){
                            map = maap;
                    },
                    setDirections: function(dir){
                        directions = dir;
                    }
                }
            },
            MapTypeId: {
                    ROADMAP: "roadmap"
            },

            LatLng: function(lat, lng) {
                return {
                    latitude: parseFloat(lat),
                    longitude: parseFloat(lng),

                    lat: function() { return this.latitude; },
                    lng: function() { return this.longitude; }
                };
            },
            Circle: function(circleOptions){
                var map = circleOptions.map;
                return {
                    circleOptions: circleOptions,
                    getMap: function(){
                        return map;
                    },
                    setMap: function(newMap){
                        map = newMap;
                    }
                }
            },
            InfoWindow: function(content){
                return{
                    content: content
                }
            },
            event:{
                addListener: function(object, event, done){
                }
            }

    }};


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