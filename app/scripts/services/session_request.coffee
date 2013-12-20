'use strict'

angular.module('webClientAngularApp')
  .service 'SessionRequest', ['$http', 'Session', 'SessionConfig', 'SessionValidate', ($http, session, config, validate) ->
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

      login: (user) ->
        sessionRequest.submit config.login(user.email, user.password), (data) ->
          validate.isValidUserObject data
          , (data) ->
              session.setUserOnline data
              session.setMessageSuccess "Login success: You are connected."
          , (data) ->
            session.setMessageError "Login error: Model user is invalid."

      logout: () ->
        session.clearSession()
        sessionRequest.submit config.logout(), (data) ->
          session.setMessageSuccess "You have been logged out."

      unlock: (userEmail) ->
        sessionRequest.submit config.unlock(userEmail), (data) ->
          session.setMessageSuccess "An unlock e-mail has been sent to your e-mail address."

      confirm: (userEmail) ->
        sessionRequest.submit config.confirm(userEmail), (data) ->
          session.setMessageSuccess "A new confirmation link has been sent to your e-mail address."

      remember: (userEmail) ->
        sessionRequest.submit config.remember(userEmail), (data) ->
          session.setMessageSuccess "Reset instructions have been sent to your e-mail address."

      register: (userObject) ->
        sessionRequest.submit config.register(userObject), (data) ->
          validate.isValidUserObject data
          , (data) ->
              session.setUserOnline data
              session.setMessageSuccess "You have been registered and logged in. A confirmation e-mail has been sent to your e-mail address, your access will terminate in 2 days if you do not use the link in that e-mail."
          , (data) ->
            session.setMessageError "Register error: Model user is invalid."

      change_password: (userEmail, userPassword, userPasswordConfirmation) ->
        sessionRequest.submit config.change_password(userEmail, userPassword, userPasswordConfirmation), (data) ->
          session.setMessageSuccess 'Your password has been updated.'

    sessionRequest
  ]
