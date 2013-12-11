'use strict'

angular.module('webClientAngularApp')
  .service 'Validate', () ->
    validate =
      isEmailValid: (email) ->
        not (email in [null, undefined]) and (/^((?!\.)[a-z0-9._%+-]+(?!\.)\w)@[a-z0-9-\.]+\.[a-z.]{2,5}(?!\.)\w$/i.test email)

      isEmpty: (string) ->
        (string in [null, undefined]) or not (/([^\s])/.test string)

      isNotEmpty: (string) ->
        not validate.isEmpty string
