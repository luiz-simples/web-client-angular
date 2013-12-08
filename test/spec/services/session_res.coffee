'use strict'

describe 'Service: SessionRes', () ->

  # load the service's module
  beforeEach module 'webClientAngularApp'

  # instantiate service
  SessionRes = {}
  beforeEach inject (_SessionRes_) ->
    SessionRes = _SessionRes_

  it 'should exists resource.', () ->
    expect(!!SessionRes).toBe true
