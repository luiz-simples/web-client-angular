'use strict'

angular.module('webClientAngularApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ui.router'
])
  .config ($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise "/"

    home =
      url: "/"
      name: "home"
      controller: 'MainCtrl'
      templateUrl: "views/main.html"

    $stateProvider.state home
