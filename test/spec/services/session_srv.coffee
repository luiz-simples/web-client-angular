'use strict'

describe 'Service: SessionSrv', () ->

  # load the service's module
  beforeEach module 'webClientAngularApp'

  # instantiate service
  SessionSrv = {}
  beforeEach inject (_SessionSrv_) ->
    SessionSrv = _SessionSrv_

  it 'should exists service.', () ->
    exist = true
    expect(!!SessionSrv).toBe exist

  it 'should start with status not logged.', () ->
    notLogged = false
    expect(SessionSrv.isLogged).toBe notLogged

  it 'should authenticate with valid user.', () ->
    expect('pending').toEqual('completed')

  it 'should change status to not logged when try connect with invalid user.', () ->
    expect('pending').toEqual('completed')

  it 'should allow access to a restricted area when user is logged.', () ->
    expect('pending').toEqual('completed')

  it 'should block access to a restricted area when user is not logged.', () ->
    expect('pending').toEqual('completed')
