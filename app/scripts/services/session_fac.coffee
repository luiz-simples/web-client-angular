'use strict'

angular.module("webClientAngularApp")
  .factory "sessionFac", ["$resource", ($resource) ->
    sessionFac =
      $resource "sessions/:sessionId.json", {},
        query:
          method: "GET"
          params: phoneId: "sessions"
          isArray: true

    sessionFac
]