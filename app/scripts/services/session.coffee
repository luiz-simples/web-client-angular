'use strict'

angular.module('webClientAngularApp')
  .service 'Session', ['SessionHelper', (sessionHelper) ->
    IS_LOGGED = true
    IS_OFFLINE = false

    session =
      user: sessionConfig.EMPTY_USER
        name: null
        email: null
        password: null
        password_confirmation: null

      messages: sessionConfig.EMPTY_MESSAGES
        error:
          message: null

      logged: IS_OFFLINE

      clearSession: () ->
        session.logged = IS_OFFLINE
        sessionHelper.clearUser(session)
        sessionHelper.clearMessage(session)

      setUserLogged: (user) ->
        session.clearSession()
        session.user = user
        session.logged = IS_LOGGED if !!session.user.email and !!session.user.name

      setErrorMessage: (errorMessage) ->
        session.messages.error.message = errorMessage

      login: (userEmail, userPassword) ->
        sessionHelper.submit \
          sessionConfig.login(userEmail, userPassword),
          () ->,
          () ->

      logout: () ->
        sessionHelper.submit \
          sessionConfig.logout(),
          () ->,
          () ->

      unlock: (userEmail) ->
        sessionHelper.submit \
          sessionConfig.unlock(userEmail),
          () ->,
          () ->

      confirm: (userEmail) ->
        sessionHelper.submit \
          sessionConfig.confirm(userEmail),
          () ->,
          () ->

      reset_password: (userEmail) ->
        sessionHelper.submit \
          sessionConfig.reset_password(userEmail),
          () ->,
          () ->

      register: (userEmail, userPassword, userPasswordConfirmation) ->
        sessionHelper.submit \
          sessionConfig.register(userEmail, userPassword, userPasswordConfirmation),
          () ->,
          () ->

      change_password: (userEmail, userPassword, userPasswordConfirmation) ->
        sessionHelper.submit \
          sessionConfig.change_password(userEmail, userPassword, userPasswordConfirmation),
          () ->,
          () ->

    session
  ]
