
var fmiService = function() {

    var STORED_QUERY_OBSERVATION = "fmi::observations::weather::multipointcoverage";
    var TEST_SERVER_URL = "http://data.fmi.fi/fmi-apikey/076c2196-7be3-49ed-8be2-5ed9f51a4883/wfs";

    var yksi = false; //  Ratkaisemassa yhtä ongelmaa. Törkeä koodin haju. Siistittävää.

    function palautaTemp(data, location) {
        var testi = false;
        function recursiveBrowse(location ,data, testi) {

            if (_.isArray(data) || _.isObject(data)) {
                // Browse all the child items of the array or object.
                _.each(data, function (value, key) {
                    if (key.toString() === "value") {
                        recursiveBrowse(location,value, true);
                    }
                    else {
                        recursiveBrowse(location, value, false);
                    }
                });
            } else {
                // This is a leaf. So, just append it after its container array or object.
                if (testi === true && yksi === false) {
                    yksi = true;       //  Ilman tätä kohtaa tulisi jostain syystä tuplana. Mysteeri...
                    $("</p>").text(location +" "+data + " C").appendTo("#weather");


                }
            }
        }

         recursiveBrowse(location, data, testi);
    }

    function handleCallback(data, location) {

        if (data) {
             as = palautaTemp(data, location);

        }

    }

    function getTemperature(location) {
        var connection = new fi.fmi.metoclient.metolib.WfsConnection();
        if (connection.connect(TEST_SERVER_URL, STORED_QUERY_OBSERVATION)) {
            // Connection was properly initialized. So, get the data.
            var currentTime = new Date();
            currentTime.getTime();

            connection.getData({
                requestParameter: "temperature",
                begin: currentTime,
                end: currentTime,
                timestep: 60 * 60 * 1000,
                sites: location,
                callback: function (data, errors) {

                    // Disconnect because the flow has finished.
                    connection.disconnect();
                    handleCallback(data, location);

                }
        })
    }}

    return {
        getTemperature: getTemperature
    }}();