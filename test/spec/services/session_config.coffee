'use strict'

describe 'Service: SessionConfig', () ->

  # load the service's module
  beforeEach module 'webClientAngularApp'

  # instantiate service
  SessionConfig = {}
  beforeEach inject (_SessionConfig_) ->
    SessionConfig = _SessionConfig_

  it 'should do something', () ->
    expect(!!SessionConfig).toBe true
