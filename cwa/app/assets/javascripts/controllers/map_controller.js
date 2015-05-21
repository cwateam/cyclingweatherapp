App.controller('MapController', function($scope){

    var bikeLayer;
    var directionsService= new google.maps.DirectionsService();
    var directionsDisplay;

     $scope.initialize = function() {
         directionsDisplay = new google.maps.DirectionsRenderer();

         var mapOptions = {
            zoom: 12,
            center: new google.maps.LatLng(60.1900, 24.9375),
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            streetViewControl: false,
            mapTypeControl: false
         };
         $scope.map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);
         directionsDisplay.setMap($scope.map);
         directionsDisplay.setPanel(document.getElementById('routingInstructions'));
         bikeLayer = new google.maps.BicyclingLayer();
         bikeLayer.setMap($scope.map);


    };

    google.maps.event.addDomListener(window, 'load', $scope.initialize);

    $scope.calcRoute = function(){
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
    };
});

