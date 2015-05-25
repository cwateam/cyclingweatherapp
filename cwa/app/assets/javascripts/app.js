var App = angular.module('App', ['ngRoute', 'templates', 'firebase']);


App.config(function($routeProvider) {
    $routeProvider
    .when('/', {
        templateUrl: "index.html",
        controller: 'HomeController'
    })
})

