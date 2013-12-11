'use strict'

describe 'Service: Session', () ->
  beforeEach ->
    @addMatchers toEqualData: (expected) ->
      angular.equals @actual, expected

  beforeEach module 'webClientAngularApp'

  # instantiate service
  Session = {}
  $httpBackend = {}

  beforeEach inject (_Session_, _$httpBackend_) ->
    Session = _Session_
    $httpBackend = _$httpBackend_

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
  it 'should clear messages in a session.', () ->
    messageErrorFake = "Error message of login"
    Session.setErrorMessage messageErrorFake
    Session.clearSession()

    emptyMessages =
      error:
        message: null

    expect(Session.messages).toEqualData emptyMessages

  #
  it 'not should change status logged with result empty data', () ->
    statusWithoutContent = 204

    $httpBackend
      .expect('POST', 'users/sign_in.json', '{"user":{"email":"test@example.com","password":"apassword"}}')
      .respond statusWithoutContent, ''

    userEmail = 'test@example.com'
    userPassword = 'apassword'
    Session.login(userEmail, userPassword)

    $httpBackend.flush()

    isOffline = false
    expect(Session.logged).toBe isOffline

  #
  it 'should login with valid user data', () ->
    statusCreated = 201

    $httpBackend
      .expect('POST', 'users/sign_in.json', '{"user":{"email":"test@example.com","password":"apassword"}}')
      .respond statusCreated,
        name: "User test"
        email: "test@example.com"

    userEmail = 'test@example.com'
    userPassword = 'apassword'
    Session.login(userEmail, userPassword)

    $httpBackend.flush()

    isLogged = true
    expect(Session.logged).toBe isLogged
    expect(Session.user).toEqualData
      name: "User test"
      email: "test@example.com"

  #
  it 'should not login without email in user data', () ->
    statusPartialInformation = 201

    $httpBackend
      .expect('POST', 'users/sign_in.json', '{"user":{"email":"test@example.com","password":"apassword"}}')
      .respond statusPartialInformation,
        name: "User test"

    userEmail = 'test@example.com'
    userPassword = 'apassword'
    Session.login(userEmail, userPassword)

    $httpBackend.flush()

    isOffline = false
    expect(Session.logged).toBe isOffline
    expect(Session.user).toEqualData
      name: null
      email: null
      password: null
      password_confirmation: null

  #
  it 'should not login without name in user data', () ->
    statusPartialInformation = 201

    $httpBackend
      .expect('POST', 'users/sign_in.json', '{"user":{"email":"test@example.com","password":"apassword"}}')
      .respond statusPartialInformation,
        email: "test@example.com"

    userEmail = 'test@example.com'
    userPassword = 'apassword'
    Session.login(userEmail, userPassword)

    $httpBackend.flush()

    isOffline = false
    expect(Session.logged).toBe isOffline
    expect(Session.user).toEqualData
      name: null
      email: null
      password: null
      password_confirmation: null
