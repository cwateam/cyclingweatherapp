var App = angular.module('App', ['ngRoute', 'templates']);


App.config(function($routeProvider) {
    $routeProvider
    .when('/', {
        templateUrl: "index.html",
        controller: 'HomeController'
    })
})

