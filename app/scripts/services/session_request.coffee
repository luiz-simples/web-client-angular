'use strict'

angular.module('webClientAngularApp')
  .service 'SessionRequest', ['$http', 'Session', 'SessionConfig', 'Validate', ($http, session, sessionConfig, validate) ->
    sessionRequest =
      submit: (parameters, callbackSuccess, callbackError) ->
        request = $http parameters

        request.success (data, status) ->
          session.setErrorMessage(data.error || data.errors) if data.error or data.errors
          callbackSuccess(data)

        request.error (data, status) ->
          messageError  = 'Unexplained error, potentially a server error, please report via support channels as this indicates a code defect. Server response was: "'
          messageError += data.error || data.errors || data + '"'
          session.setMessageError messageError
          callbackError(data, status) if callbackError

      login: (userEmail, userPassword) ->
        sessionRequest.submit sessionConfig.login(userEmail, userPassword), (data) ->
          if data instanceof Object and validate.isNotEmpty(data.email) and validate.isEmailValid(data.email) and validate.isNotEmpty(data.name)
            session.setUserOnline data
            session.setMessageSuccess "Login success: You are connected."
          else
            session.setMessageError "Login error: Model user is invalid."

      logout: () ->
        session.clearSession()
        sessionRequest.submit sessionConfig.logout(), (data) ->
          session.setMessageSuccess "You have been logged out."

      unlock: (userEmail) ->
        sessionRequest.submit sessionConfig.unlock(userEmail), (data) ->

      confirm: (userEmail) ->
        sessionRequest.submit sessionConfig.confirm(userEmail), (data) ->

      reset_password: (userEmail) ->
        sessionRequest.submit sessionConfig.reset_password(userEmail), (data) ->

      register: (userEmail, userPassword, userPasswordConfirmation) ->
        sessionRequest.submit sessionConfig.register(userEmail, userPassword, userPasswordConfirmation), (data) ->

      change_password: (userEmail, userPassword, userPasswordConfirmation) ->
        sessionRequest.submit sessionConfig.change_password(userEmail, userPassword, userPasswordConfirmation), (data) ->

    sessionRequest
  ]