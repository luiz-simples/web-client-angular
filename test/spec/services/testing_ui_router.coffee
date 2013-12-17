'use strict'

describe 'Service: TestingUiRouter', () ->

  # load the service's module
  beforeEach module 'webClientAngularApp'

  # instantiate service
  TestingUiRouter = {}
  beforeEach inject (_TestingUiRouter_) ->
    TestingUiRouter = _TestingUiRouter_

  it 'should do something', () ->
    expect(!!TestingUiRouter).toBe true
