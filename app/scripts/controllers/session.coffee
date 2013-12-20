'use strict'

angular.module('webClientAngularApp')
  .controller 'SessionCtrl', ["$scope", "SessionRequest", "SessionValidate", (scope, request, validate) ->
    empty = null

    scope.app =
      name: "Web client with AngularJS"
      page: "Login"

    scope.messages =
      user:
        email: empty
        password: empty

    scope.user =
      email: empty
      password: empty

    clearMessages = () ->
      scope.messages.user.email = empty
      scope.messages.user.password = empty

    userIsAuthenticable = () ->
      emailFilled = validate.isNotEmpty scope.user.email, () ->
        scope.messages.user.email = "Email unfilled."

      emailValid = validate.isEmail scope.user.email, () ->
        scope.messages.user.email = "Email inválid."

      passwordFilled = validate.isNotEmpty scope.user.password, () ->
        scope.messages.user.password = "Password unfilled."

      emailFilled and emailValid and passwordFilled

    scope.access = () ->
      clearMessages()
      request.login(scope.user) if userIsAuthenticable()
  ]
