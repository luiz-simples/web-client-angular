'use strict'

angular.module('webClientAngularApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ui.router'
])
  .config ($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise "/"

    $stateProvider
      .state "main",
        url: "/"
        templateUrl: "views/main.html"
        controller: 'MainCtrl'
