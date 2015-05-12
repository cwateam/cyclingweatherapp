var map;

function initialize() {
    var mapOptions = {
        center: new google.maps.LatLng(60.1900, 24.9375),
        zoom: 12,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        streetViewControl: false,
        mapTypeControl: false,
    };
    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
}


google.maps.event.addDomListener(window, 'load', initialize);
