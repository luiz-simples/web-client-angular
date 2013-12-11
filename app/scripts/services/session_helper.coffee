'use strict'

angular.module('webClientAngularApp')
  .service 'SessionHelper', ["$http", ($http) ->
    sessionHelper =
      clearMessage: (session) ->
        session.messages.error.message = null

      clearUser: (session) ->
        session.user.name = null
        session.user.email = null
        session.user.password = null
        session.user.password_confirmation = null

      submit: (parameters, callbackSuccess, callbackError) ->
        request = $http(parameters)
        request.success(callbackSuccess)
        request.error(callbackError)

      errorRequest: (data, status) ->
        session.clearSession()
        session.setErrorMessage(data.errors or data.error)

    sessionHelper
  ]
