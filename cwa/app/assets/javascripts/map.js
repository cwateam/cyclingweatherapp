var map;
var bikeLayer;

var directionsDisplay;
var directionsService = new google.maps.DirectionsService();

function initialize() {
    directionsDisplay = new google.maps.DirectionsRenderer();
    var mapOptions = {
        center: new google.maps.LatLng(60.1900, 24.9375),
        zoom: 12,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        streetViewControl: false,
        mapTypeControl: false,
    };
    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
    directionsDisplay.setMap(map);
    directionsDisplay.setPanel(document.getElementById('routingInstructions'));

    bikeLayer = new google.maps.BicyclingLayer();
    bikeLayer.setMap(map);
}

function calcRoute() {
    var x = document.getElementById("routingForm");

    var start = x.elements[0].value;
    var end = x.elements[1].value;
    
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
}

google.maps.event.addDomListener(window, 'load', initialize);
