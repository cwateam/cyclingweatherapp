App.service('FirebaseService', function($firebase) {

    var firebaseRef = new Firebase('https://glowing-inferno-7580.firebaseio.com/fmi_temp');

    var geoFire = new GeoFire(firebaseRef);

    var getData = function (latitude, longitude, radius, done) {
        var geoQuery = geoFire.query({
            center: [60.1900, 24.9375],
            radius: 25
        });
        geoQuery.on("key_entered", function (key, value) {
            firebaseRef.orderByKey().equalTo(key).on("child_added", function (snapshot) {
                done(snapshot.val());
            });
        });
    }
    
    return {
        getData: getData
    }
});
