var App = angular.module('App', ['ngRoute','firebase']);

App.config(function($routeProvider) {
    $routeProvider
    .when('/', {
        controller: 'HomeController'
    })
});

