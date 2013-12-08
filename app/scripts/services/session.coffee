'use strict'

angular.module('webClientAngularApp')
  .service 'Session', () ->
    sdo =
      isLogged: false
