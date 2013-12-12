'use strict'

describe 'Service: SessionRequest', () ->
  beforeEach ->
    @addMatchers toEqualData: (expected) ->
      angular.equals @actual, expected

  # load the service's module
  beforeEach module 'webClientAngularApp'

  # instantiate service
  sessionRequest = {}
  $httpBackend = {}
  session = {}
  isOffline = false
  isLogged = true

  setUserFakeLogged = () ->
    session.setUserOnline
      name: "User test"
      email: "test@example.com"
    expect(session.logged).toBe isLogged

  beforeEach inject (_SessionRequest_, _$httpBackend_, _Session_) ->
    sessionRequest = _SessionRequest_
    $httpBackend = _$httpBackend_
    session = _Session_

  it 'should service exist', () ->
    exist = true
    expect(!!sessionRequest).toBe exist

  describe 'Login:', () ->
    it 'not should change status logged with result empty data', () ->
      statusWithoutContent = 204

      $httpBackend
        .expect('POST', 'users/sign_in.json', '{"user":{"email":"test@example.com","password":"apassword"}}')
        .respond(statusWithoutContent, '')

      userEmail = 'test@example.com'
      userPassword = 'apassword'
      sessionRequest.login(userEmail, userPassword)

      $httpBackend.flush()
      expect(session.logged).toBe isOffline
      expect(session.user).toEqualData
        name: null
        email: null
        password: null
        password_confirmation: null

      expect(session.messages.success).toEqual null
      expect(session.messages.error).toEqual 'Login error: Model user is invalid.'

    it 'should login with valid user data', () ->
      statusCreated = 201

      $httpBackend
        .expect('POST', 'users/sign_in.json', '{"user":{"email":"test@example.com","password":"apassword"}}')
        .respond statusCreated,
          name: "User test"
          email: "test@example.com"

      userEmail = 'test@example.com'
      userPassword = 'apassword'
      sessionRequest.login(userEmail, userPassword)

      $httpBackend.flush()

      expect(session.logged).toBe isLogged
      expect(session.user).toEqualData
        name: "User test"
        email: "test@example.com"

      expect(session.messages.success).toEqual "Login success: You are connected."
      expect(session.messages.error).toEqual null

    it 'should not login without email in user data', () ->
      statusPartialInformation = 201

      $httpBackend
        .expect('POST', 'users/sign_in.json', '{"user":{"email":"test@example.com","password":"apassword"}}')
        .respond statusPartialInformation,
          name: "User test"

      userEmail = 'test@example.com'
      userPassword = 'apassword'
      sessionRequest.login(userEmail, userPassword)

      $httpBackend.flush()
      expect(session.logged).toBe isOffline
      expect(session.user).toEqualData
        name: null
        email: null
        password: null
        password_confirmation: null

      expect(session.messages.success).toEqual null
      expect(session.messages.error).toEqual 'Login error: Model user is invalid.'

    it 'should not login without name in user data', () ->
      statusPartialInformation = 201

      $httpBackend
        .expect('POST', 'users/sign_in.json', '{"user":{"email":"test@example.com","password":"apassword"}}')
        .respond statusPartialInformation,
          email: "test@example.com"

      userEmail = 'test@example.com'
      userPassword = 'apassword'
      sessionRequest.login(userEmail, userPassword)

      $httpBackend.flush()
      expect(session.logged).toBe isOffline
      expect(session.user).toEqualData
        name: null
        email: null
        password: null
        password_confirmation: null

      expect(session.messages.success).toEqual null
      expect(session.messages.error).toEqual 'Login error: Model user is invalid.'

  describe 'Logout:', () ->
    it 'should change status to offline when call', () ->
      setUserFakeLogged()
      $httpBackend.expect('DELETE', 'users/sign_out.json', null).respond 201, ''
      sessionRequest.logout()
      $httpBackend.flush()
      expect(session.logged).toBe isOffline
      expect(session.messages.error).toEqual null
      expect(session.messages.success).toEqual 'You have been logged out.'

    it 'success 204', () ->
      setUserFakeLogged()
      $httpBackend.expect('DELETE', 'users/sign_out.json', null).respond 204, ''
      sessionRequest.logout()
      $httpBackend.flush()
      expect(session.logged).toBe isOffline
      expect(session.messages.error).toEqual null
      expect(session.messages.success).toEqual 'You have been logged out.'

    it 'fail 401', () ->
      setUserFakeLogged()
      $httpBackend.expect('DELETE', 'users/sign_out.json', null).respond 401, 'error returned by the server'
      sessionRequest.logout()
      $httpBackend.flush()
      expect(session.logged).toBe isOffline
      expect(session.messages.error).toEqual 'Unexplained error, potentially a server error, please report via support channels as this indicates a code defect. Server response was: "error returned by the server"'
      expect(session.messages.success).toEqual null
