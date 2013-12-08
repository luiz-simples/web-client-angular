'use strict'

describe 'Service: Session', () ->

  # load the service's module
  beforeEach module 'webClientAngularApp'

  # instantiate service
  Session = {}
  beforeEach inject (_Session_) ->
    Session = _Session_

  it 'should exists', () ->
    exist = true
    expect(!!Session).toBe exist
