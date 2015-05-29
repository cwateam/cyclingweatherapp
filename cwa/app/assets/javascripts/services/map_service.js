App.service('MapService', function(){

    var directionsDisplay;


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
        if (directionsDisplay != null){
            directionsDisplay.setMap(null);
        }

        var directionsService= new google.maps.DirectionsService();
        directionsDisplay = new google.maps.DirectionsRenderer();
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
        var icon = 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png';

        if (source === 'fmi'){
            icon = 'http://maps.google.com/mapfiles/ms/icons/red-dot.png';
        }

        var marker = new google.maps.Marker({
            position: new google.maps.LatLng(lat, lng),
            title:  value +' °'+type +'\n' +"from: " +source,
            source: source,
            icon: icon
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

