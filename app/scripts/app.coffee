'use strict'

angular.module('webClientAngularApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ui.router'
]).config ($stateProvider, $urlRouterProvider) ->
  $stateProvider
    .state
      url: "/"
      name: "home"
      controller: 'MainCtrl'
      templateUrl: "views/main.html"

    .state
      url: "/login"
      name: "login"
      controller: 'LoginCtrl'
      templateUrl: "views/session/login.html"

  $urlRouterProvider.otherwise "/"
