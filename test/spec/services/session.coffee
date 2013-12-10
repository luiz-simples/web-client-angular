'use strict'

describe 'Service: Session', () ->
  beforeEach ->
    @addMatchers toEqualData: (expected) ->
      angular.equals @actual, expected

  beforeEach module 'webClientAngularApp'

  # instantiate service
  Session = {}
  beforeEach inject (_Session_) ->
    Session = _Session_

  #
  it 'should exist Session service.', () ->
    objExist = true
    expect(!!Session).toBe objExist

  #
  it 'should be initialized with offline status.', () ->
    isOffline = false
    expect(Session.logged).toBe isOffline

  #
  it 'should be initialized with empty user.', () ->
    userEmpty =
      name: null
      email: null
      password: null
      password_confirmation: null

    expect(Session.user).toEqualData userEmpty

  #
  it 'should be initialized with empty messages.', () ->
    emptyMessages =
      error:
        message: null

    expect(Session.messages).toEqualData emptyMessages

  #
  it 'should change to online status when set user logged.', () ->
    userFake =
      name: "User Fake"
      email: "teste@teste.com.br"
      password: ""

    Session.setUserLogged userFake

    isLogged = true
    expect(Session.logged).toBe isLogged

  #
  it 'should not change to online status when set invalid user.', () ->
    userFake =
      name: null
      email: "teste@teste.com.br"
      password: ""

    Session.setUserLogged userFake

    isOffline = false
    expect(Session.logged).toBe isOffline

  #
  it 'should clear messages in a session.', () ->
    messageErrorFake = "Error message of login"
    Session.setErrorMessage messageErrorFake
    Session.clearSession()

    emptyMessages =
      error:
        message: null

    expect(Session.messages).toEqualData emptyMessages

  #
  it 'should clear user in a session.', () ->
    userFake =
      name: null
      email: "teste@teste.com.br"
      password: ""

    Session.setUserLogged userFake
    Session.clearSession()

    userEmpty =
      name: null
      email: null
      password: null
      password_confirmation: null

    expect(Session.user).toEqualData userEmpty
