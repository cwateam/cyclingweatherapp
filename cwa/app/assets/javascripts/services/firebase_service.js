App.service('FirebaseService', function($firebase) {

    var firebaseTemperatureRef = new Firebase('https://glowing-inferno-7580.firebaseio.com/fmi_temp');
    var geoFire = new GeoFire(firebaseTemperatureRef);



    var getTemperatureData = function (latitude, longitude, radius, done) {
        var geoQuery = geoFire.query({
            center: [60.1900, 24.9375],
            radius: 1000
        });
        geoQuery.on("key_entered", function (key, value) {
            firebaseTemperatureRef.orderByKey().equalTo(key).on("child_added", function (snapshot) {
                done(snapshot.val());
            });
        });
    }

    
    return {
        getTempData: getTemperatureData
    }
});
