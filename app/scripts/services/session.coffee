'use strict'

angular.module('webClientAngularApp')
  .service 'Session', () ->
    session =
      logged: false

      user:
        name: null
        email: null
        password: null
        password_confirmation: null

      messages:
        error: null
        success: null

      clearSession: () ->
        session.logged = false
        session.clearUser()
        session.clearMessage()

      setMessageError: (errorMessage) ->
        session.messages.error = errorMessage

      setMessageSuccess: (messageSuccess) ->
        session.messages.success = messageSuccess

      setUserOnline: (user) ->
        session.clearSession()
        session.logged = true
        session.user = user

      clearMessage: () ->
        session.messages.error = null
        session.messages.success = null

      clearUser: () ->
        session.user.name = null
        session.user.email = null
        session.user.password = null
        session.user.password_confirmation = null

    session
