var FmiController = function(){

function getTemperature(location){
    fmiService.getTemperature(location);
}
return{
    getTemperature: getTemperature
}
}();