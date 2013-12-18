'use strict'

angular.module('webClientAngularApp')
  .constant 'SessionConfig',
    register: (userObject) ->
      method: 'POST',
      url: 'sessions/users.json',
      data:
        user: userObject

    confirm: (userEmail) ->
      method: 'POST',
      url: 'sessions/confirmation.json',
      data:
        user:
          email: userEmail

    unlock: (userEmail) ->
      method: 'POST',
      url: 'sessions/unlock.json',
      data:
        user:
          email: userEmail

    logout: () ->
      method: 'DELETE',
      url: 'sessions/sign_out.json',

    login: (userEmail, userPassword) ->
      method: 'POST',
      url: 'sessions/sign_in.json',
      data:
        user:
          email: userEmail
          password: userPassword

    password_reset: (userEmail) ->
      method: 'POST',
      url: 'sessions/password.json',
      data:
        user:
          email: userEmail

    change_password: (userEmail, userPassword, userPasswordConfirmation) ->
      method: 'PUT',
      url: 'sessions/password.json',
      data:
        user:
          email: userEmail
          password: userPassword
          password_confirmation: userPasswordConfirmation
