'use strict'

describe 'Service: Session', () ->
  beforeEach ->
    @addMatchers toEqualData: (expected) ->
      angular.equals @actual, expected

  beforeEach module 'webClientAngularApp'

  # instantiate service
  session = {}

  beforeEach inject (_Session_) ->
    session = _Session_

  it 'should exist session service.', () ->
    objExist = true
    expect(!!session).toBe objExist

  it 'should be initialized with offline status.', () ->
    isOffline = false
    expect(session.logged).toBe isOffline

  it 'should be initialized with empty user.', () ->
    expect(session.user).toEqualData
      name: null
      email: null
      password: null
      password_confirmation: null

  it 'should be initialized with empty messages.', () ->
    expect(session.messages).toEqualData
      error: null
      success: null

  it 'should clear messages in a session.', () ->
    messageErrorFake = "Error message of login"
    session.setMessageError messageErrorFake
    expect(session.messages).toEqualData
      error: messageErrorFake
      success: null

    session.clearSession()
    expect(session.messages).toEqualData
      error: null
      success: null
