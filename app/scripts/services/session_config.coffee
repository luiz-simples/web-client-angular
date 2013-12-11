'use strict'

angular.module('webClientAngularApp')
  .constant 'SessionConfig',
      IS_LOGGED: true
      IS_OFFLINE: false

      EMPTY_USER:
        name: null
        email: null
        password: null
        password_confirmation: null

      EMPTY_MESSAGES:
        error:
          message: null

      login: (userEmail, userPassword) ->
        method: 'POST',
        url: 'users/sign_in.json',
        data:
          user:
            email: userEmail
            password: userPassword

      logout: () ->
        method: 'DELETE',
        url: 'users/sign_out.json',

      password_reset: (userEmail) ->
        method: 'POST',
        url: 'users/password.json',
        data:
          user:
            email: userEmail

      unlock: (userEmail) ->
        method: 'POST',
        url: 'users/unlock.json',
        data:
          user:
            email: userEmail

      confirm: (userEmail) ->
        method: 'POST',
        url: 'users/confirmation.json',
        data:
          user:
            email: userEmail

      register: (userEmail, userPassword, userPasswordConfirmation) ->
        method: 'POST',
        url: 'users/users.json',
        data:
          user:
            email: userEmail
            password: userPassword
            password_confirmation: userPasswordConfirmation

      change_password: (userEmail, userPassword, userPasswordConfirmation) ->
        method: 'PUT',
        url: 'users/users.json',
        data:
          user:
            email: userEmail
            password: userPassword
            password_confirmation: userPasswordConfirmation
