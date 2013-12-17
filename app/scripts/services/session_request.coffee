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
          validate.isValidUserObject data
          , (data) ->
              session.setUserOnline data
              session.setMessageSuccess "Login success: You are connected."
          , (data) ->
            session.setMessageError "Login error: Model user is invalid."

      logout: () ->
        session.clearSession()
        sessionRequest.submit sessionConfig.logout(), (data) ->
          session.setMessageSuccess "You have been logged out."

      unlock: (userEmail) ->
        sessionRequest.submit sessionConfig.unlock(userEmail), (data) ->
          session.setMessageSuccess "An unlock e-mail has been sent to your e-mail address."

      confirm: (userEmail) ->
        sessionRequest.submit sessionConfig.confirm(userEmail), (data) ->
          session.setMessageSuccess "A new confirmation link has been sent to your e-mail address."

      reset_password: (userEmail) ->
        sessionRequest.submit sessionConfig.password_reset(userEmail), (data) ->
          session.setMessageSuccess "Reset instructions have been sent to your e-mail address."

      register: (userObject) ->
        sessionRequest.submit sessionConfig.register(userObject), (data) ->
          validate.isValidUserObject data
          , (data) ->
              session.setUserOnline data
              session.setMessageSuccess "You have been registered and logged in. A confirmation e-mail has been sent to your e-mail address, your access will terminate in 2 days if you do not use the link in that e-mail."
          , (data) ->
            session.setMessageError "Register error: Model user is invalid."

      change_password: (userEmail, userPassword, userPasswordConfirmation) ->
        sessionRequest.submit sessionConfig.change_password(userEmail, userPassword, userPasswordConfirmation), (data) ->
          session.setMessageSuccess 'Your password has been updated.'

    sessionRequest
  ]
