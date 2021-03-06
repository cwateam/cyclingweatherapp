var MapServiceMock;
var FirebaseServiceMock;
var mapMock;
var scope, controller, parent;
var marker;
var google = {};
var directionsDisplayMap;
var directionsDisplayPanel;
var directions;

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
            DirectionsStatus: {
                OK: "ok"
            },

            DirectionsService: function(){
                return {
                    route: function(request, done){
                        done(request, google.maps.DirectionsStatus.OK);
                    }
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

            OverlayView: function(){
                this.map;
                var setMap = function(newMap){
                    this.map = newMap;
                }
                return {
                    setMap: setMap,
                }
            },

            DirectionsRenderer: function(){
                var map;
                return {
                    setPanel: function(newPanel){
                        directionsDisplayPanel = newPanel;
                    },
                    setMap : function(newMap){
                        directionsDisplayMap = newMap;
                    },
                    setDirections: function(dir){
                        directions = dir;
                    }
                }
            },
            MapTypeId: {
                    ROADMAP: "roadmap"
            },

            LatLngBounds: function(sw, ne){
                this.sw = sw;
                this.ne = ne;
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
                },
                addListenerOnce: function(object, event, done) {}
            },
            TravelMode: {
                BICYCLING: "bicycling"
            }

    }};

    GdalOverlay.prototype = new google.maps.OverlayView();

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