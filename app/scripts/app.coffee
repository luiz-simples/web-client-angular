'use strict'

angular.module('webClientAngularApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ui.router'
]).config ($stateProvider, $urlRouterProvider) ->
  $stateProvider
    .state 'session',
      abstract: true
      views:
        "":
          templateUrl: 'views/session/session.html'
          controller: 'SessionCtrl'

    .state
      parent: 'session'
      url: "/login"
      name: "login"
      controller: 'SessionCtrl'
      templateUrl: "views/session/login.html"

    .state
      parent: 'session'
      url: "/sign-up"
      name: "sign-up"
      controller: 'SessionCtrl'
      templateUrl: "views/session/sign-up.html"

  $urlRouterProvider.otherwise "/login"
