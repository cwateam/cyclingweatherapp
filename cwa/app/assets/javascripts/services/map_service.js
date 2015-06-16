


App.service('MapService', function(){

    var directionsDisplay;
    var bikeLayer;

    var overlay;

    var addOverlay = function(map){
        var srcImage = 'http://www.cs.helsinki.fi/u/ajvuolas/kuvat/fmi_test.png';
        var bounds = new google.maps.LatLngBounds(new google.maps.LatLng(59.7, 24.4), new google.maps.LatLng(60.7,25.4));
        overlay = new GdalOverlay(bounds, srcImage, map);
    }

    var initialize = function() {
        var mapOptions = {
            zoom: 12,
            center: new google.maps.LatLng(60.1900, 24.9375),
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            streetViewControl: false,
            mapTypeControl: true
        };

        var map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);
        bikeLayer = new google.maps.BicyclingLayer();
        bikeLayer.setMap(map);
        addOverlay(map)
        return map;
    };


    var toggleBikeOverlay = function(map){
        if(bikeLayer.getMap() !== null){
            bikeLayer.setMap(null);
        } else {
            bikeLayer.setMap(map);
        }
    };

    var calcRoute = function(map, start, end){
        if (directionsDisplay != null){
            clearRoute();
        };
        var directionsService= new google.maps.DirectionsService();
        directionsDisplay = new google.maps.DirectionsRenderer();
        directionsDisplay.setPanel(document.getElementById("directionsTarget"));
        directionsDisplay.setMap(map);
        var request = {
            origin: start,
            destination: end,
            travelMode: google.maps.TravelMode.BICYCLING
        };
        directionsService.route(request, function(response, status) {
            if (status == google.maps.DirectionsStatus.OK) {
                directionsDisplay.setDirections(response);
            };
        });
    };

    var clearRoute = function(){
        if (directionsDisplay != null) {
            directionsDisplay.setMap(null);
            directionsDisplay.setPanel(null)
        }
    };

    var addMarker = function(map,lat, lng, type, value, source, done){
        /*var icon = 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png';
        if (source === 'fmi'){
            icon = 'http://maps.google.com/mapfiles/ms/icons/red-dot.png';
        };

        var marker = new google.maps.Marker({
            position: new google.maps.LatLng(lat, lng),
            source: source,
            icon: icon
        });

        marker.setMap(map);
        */
        //green

        if (value > 25){
            var color = '#FF0000';
        } else if (value > 10){
            var color = '#00FF00';

        } else if (value > 0){
            var color = '#0000FF';
        }else {

        }


        var circleOptions = {
            center: new google.maps.LatLng(lat, lng),
            fillColor: color,
            fillOpacity: 0.05,
            map: map,
            radius: 500,
            strokeWeight: 0,
            clickable: true

        }

        var circle = new google.maps.Circle(circleOptions);

        var infowindow = new google.maps.InfoWindow({
            content: value +' °'+type +'\n' +"from: " +source
        });
        circle.infowindow = infowindow;


        google.maps.event.addListener(circle, 'mouseover', function(ev) {
            circle.infowindow.setPosition(circle.getCenter());
            circle.infowindow.open(map, circle);
        });
        google.maps.event.addListener(circle, 'mouseout', function() {
            circle.infowindow.close(map,circle);
        });

        done(circle);

    }
    var getBicycleOverlay = function(){
        return bikeLayer;
    }

    return{
        initialize: initialize,
        addMarker: addMarker,
        calcRoute: calcRoute,
        toggleBikeOverlay: toggleBikeOverlay,
        getBicycleOverlay: getBicycleOverlay,
        clearRoute: clearRoute
    };
});

