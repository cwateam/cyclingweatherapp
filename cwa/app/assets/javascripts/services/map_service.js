App.service('MapService', function(){




    var initialize = function() {
        var mapOptions = {
            zoom: 12,
            center: new google.maps.LatLng(60.1900, 24.9375),
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            streetViewControl: false,
            mapTypeControl: false
        };

        var map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);
        var bikeLayer;
        bikeLayer = new google.maps.BicyclingLayer();
        bikeLayer.setMap(map);
        return map;

    };

    var calcRoute = function(map, start, end){
        var directionsService= new google.maps.DirectionsService();
        var directionsDisplay = new google.maps.DirectionsRenderer();
        directionsDisplay.setMap(map);
        var request = {
            origin: start,
            destination: end,
            travelMode: google.maps.TravelMode.BICYCLING
        };
        directionsService.route(request, function(response, status) {
            if (status == google.maps.DirectionsStatus.OK) {
                directionsDisplay.setDirections(response);
            }
        });
    };

    var addMarker = function(map,lat, lng, type, value, source, done){
        var marker = new google.maps.Marker({
            position: new google.maps.LatLng(lat, lng),
            title:  value +' °'+type +'\n' +"from: " +source,
            source: source
        });
        marker.setMap(map);
        done(marker);

    }
    return{
        initialize: initialize,
        addMarker: addMarker,
        calcRoute: calcRoute
    }
});

