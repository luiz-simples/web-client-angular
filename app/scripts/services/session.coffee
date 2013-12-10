'use strict'

angular.module('webClientAngularApp')
  .service 'Session', ['SessionHelper', (sessionHelper) ->
    IS_LOGGED = true
    IS_OFFLINE = false

    session =
      user:
        name: null
        email: null
        password: null
        password_confirmation: null

      messages:
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

    session
  ]
