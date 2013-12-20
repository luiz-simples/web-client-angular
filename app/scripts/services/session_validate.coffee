'use strict'

angular.module('webClientAngularApp')
  .service 'SessionValidate', () ->
    validate =
      isEmail: (email, callback) ->
        emailValid = not (email in [null, undefined]) and (/^((?!\.)[a-z0-9._%+-]+(?!\.)\w)@[a-z0-9-\.]+\.[a-z.]{2,5}(?!\.)\w$/i.test email)
        if !emailValid and callback? then callback()
        emailValid

      isEmpty: (string) ->
        (string in [null, undefined]) or not (/([^\s])/.test string)

      isNotEmpty: (string, callback) ->
        stringFilled = not validate.isEmpty string
        if !stringFilled and callback? then callback()
        stringFilled

      isValidUserObject: (data, callbackIfTrue, callbackIfFalse) ->
        validUser = data instanceof Object and validate.isNotEmpty(data.email) and validate.isEmail(data.email) and validate.isNotEmpty(data.name)
        if validUser then callbackIfTrue(data) else callbackIfFalse(data)

    validate
