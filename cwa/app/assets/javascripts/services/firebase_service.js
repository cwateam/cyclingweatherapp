App.service('FirebaseService', function($firebase) {

    var firebaseFmiTemperatureRef = new Firebase('https://glowing-inferno-7580.firebaseio.com/fmi_temp');
    var firebaseThingseeTemperatureRef = new Firebase('https://glowing-inferno-7580.firebaseio.com/thingsee_temp');
    var fmiGeoFire = new GeoFire(firebaseFmiTemperatureRef);
    var thingseeGeoFire = new GeoFire(firebaseThingseeTemperatureRef);




    var getTemperatureData = function (lat, lng, radius, done) {
        var fmiGeoQuery = initQuery(fmiGeoFire, lat, lng, radius);
        query(fmiGeoQuery,firebaseFmiTemperatureRef, done);
        var thingseeGeoQuery = initQuery(thingseeGeoFire, lat, lng, radius);
        query(thingseeGeoQuery, firebaseThingseeTemperatureRef, done);

    };

    var query = function(geoQuery,firebaseRef, done){
        geoQuery.on("key_entered", function (key) {
            firebaseRef.orderByKey().equalTo(key).on("child_added", function (snapshot) {
                done(snapshot.val());
            });
        });
    };

    var initQuery = function(geoFire, lat, lng, radius){
        var ret = geoFire.query({
            center: [lat, lng],
            radius: radius
        });
        return ret;
    }

    
    return {
        getTempData: getTemperatureData
    }
});
