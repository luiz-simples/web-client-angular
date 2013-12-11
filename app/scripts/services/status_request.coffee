'use strict'

angular.module('webClientAngularApp')
  .service 'StatusRequest', () ->
    STATUS_CREATED = 201
    STATUS_ACCEPTED = 202
    STATUS_PARTIAL_INFORMATION = 203
    STATUS_WITHOUT_CONTENT = 204
    STATUS_UNPROCESSABLE_ENTITY = 422

    statusRequest =
      isStatusSuccess: (status) ->
        status in [STATUS_CREATED, STATUS_ACCEPTED, STATUS_PARTIAL_INFORMATION, STATUS_WITHOUT_CONTENT]

      isStatusError: (status) ->
        status is STATUS_UNPROCESSABLE_ENTITY or status not in [STATUS_CREATED, STATUS_WITHOUT_CONTENT]

    statusRequest
