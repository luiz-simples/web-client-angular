'use strict'

angular.module('webClientAngularApp')
  .service 'SessionHelper', () ->
    sessionHelper =
      clearMessage: (session) ->
        session.messages.error.message = null

      clearUser: (session) ->
        session.user.name = null
        session.user.email = null
        session.user.password = null
        session.user.password_confirmation = null

    sessionHelper
