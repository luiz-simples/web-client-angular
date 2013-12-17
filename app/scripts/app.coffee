'use strict'

angular.module('webClientAngularApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ui.router'
])
  .config ($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise "/"

    $stateProvider.state
      url: "/"
      name: "home"
      controller: 'MainCtrl'
      templateUrl: "views/main.html"

