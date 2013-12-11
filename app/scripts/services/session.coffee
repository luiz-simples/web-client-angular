'use strict'

angular.module('webClientAngularApp')
  .service 'Session',
    ['SessionHelper', 'SessionConfig', 'StatusRequest', 'Validate', (sessionHelper, sessionConfig, statusRequest, validate) ->
      session =
        user: sessionConfig.EMPTY_USER
        logged: sessionConfig.IS_OFFLINE
        messages: sessionConfig.EMPTY_MESSAGES

        clearSession: () ->
          session.logged = sessionConfig.IS_OFFLINE
          sessionHelper.clearUser(session)
          sessionHelper.clearMessage(session)

        setErrorMessage: (errorMessage) ->
          session.messages.error.message = errorMessage

        login: (userEmail, userPassword) ->
          sessionHelper.submit \
            sessionConfig.login(userEmail, userPassword),
            (data, status) ->
              session.setErrorMessage(data.error || data.errors) if data.error or statusRequest.isStatusError(status)

              if statusRequest.isStatusSuccess(status)
                session.clearSession()

                if data instanceof Object and validate.isNotEmpty(data.name) and validate.isEmailValid(data.email) and validate.isNotEmpty(data.name)
                  session.user = data
                  session.logged = sessionConfig.IS_LOGGED
                else
                  session.setErrorMessage("Login error: Model user is invalid.")
            ,
            session.setErrorMessage

        logout: () ->
          sessionHelper.submit \
            sessionConfig.logout(),
            (data, status) ->
            ,
            session.setErrorMessage

        unlock: (userEmail) ->
          sessionHelper.submit \
            sessionConfig.unlock(userEmail),
            (data, status) ->
            ,
            session.setErrorMessage

        confirm: (userEmail) ->
          sessionHelper.submit \
            sessionConfig.confirm(userEmail),
            (data, status) ->
            ,
            session.setErrorMessage

        reset_password: (userEmail) ->
          sessionHelper.submit \
            sessionConfig.reset_password(userEmail),
            (data, status) ->
            ,
            session.setErrorMessage

        register: (userEmail, userPassword, userPasswordConfirmation) ->
          sessionHelper.submit \
            sessionConfig.register(userEmail, userPassword, userPasswordConfirmation),
            (data, status) ->
            ,
            session.setErrorMessage

        change_password: (userEmail, userPassword, userPasswordConfirmation) ->
          sessionHelper.submit \
            sessionConfig.change_password(userEmail, userPassword, userPasswordConfirmation),
            (data, status) ->
            ,
            session.setErrorMessage

      session
    ]
