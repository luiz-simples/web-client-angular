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
  emailFake = "test@example.com"
  uservalid =
    name: "User test"
    email: "test@example.com"

  setUserFakeLogged = () ->
    session.setUserOnline uservalid
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
      statusCreated = 201

      $httpBackend
        .expect('POST', 'sessions/sign_in.json', '{"user":{"email":"test@example.com","password":"apassword"}}')
        .respond(statusCreated, '')

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
      statusSuccess = 204
      $httpBackend
        .expect('POST', 'sessions/sign_in.json', '{"user":{"email":"test@example.com","password":"apassword"}}')
        .respond statusSuccess,
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
      statusPartialInformation = 203

      $httpBackend
        .expect('POST', 'sessions/sign_in.json', '{"user":{"email":"test@example.com","password":"apassword"}}')
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
      statusPartialInformation = 203

      $httpBackend
        .expect('POST', 'sessions/sign_in.json', '{"user":{"email":"test@example.com","password":"apassword"}}')
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
      $httpBackend.expect('DELETE', 'sessions/sign_out.json', null).respond 201, ''
      sessionRequest.logout()
      $httpBackend.flush()
      expect(session.logged).toBe isOffline
      expect(session.messages.error).toEqual null
      expect(session.messages.success).toEqual 'You have been logged out.'

    it 'success 204', () ->
      setUserFakeLogged()
      $httpBackend.expect('DELETE', 'sessions/sign_out.json', null).respond 204, ''
      sessionRequest.logout()
      $httpBackend.flush()
      expect(session.logged).toBe isOffline
      expect(session.messages.error).toEqual null
      expect(session.messages.success).toEqual 'You have been logged out.'

    it 'fail 401', () ->
      setUserFakeLogged()
      $httpBackend.expect('DELETE', 'sessions/sign_out.json', null).respond 401, 'error returned by the server'
      sessionRequest.logout()
      $httpBackend.flush()
      expect(session.logged).toBe isOffline
      expect(session.messages.error).toEqual 'Unexplained error, potentially a server error, please report via support channels as this indicates a code defect. Server response was: "error returned by the server"'
      expect(session.messages.success).toEqual null

  describe 'Unlock:', () ->
    it 'success 204', () ->
      $httpBackend.expect('POST', 'sessions/unlock.json', '{"user":{"email":"test@example.com"}}').respond 204, ''
      sessionRequest.unlock emailFake
      $httpBackend.flush()
      expect(session.messages.error).toEqual null
      expect(session.messages.success).toEqual 'An unlock e-mail has been sent to your e-mail address.'

    it 'fail 401', () ->
      $httpBackend.expect('POST', 'sessions/unlock.json', '{"user":{"email":"test@example.com"}}').respond 401, 'Error message Unlock'
      sessionRequest.unlock emailFake
      $httpBackend.flush()
      expect(session.messages.error).toEqual 'Unexplained error, potentially a server error, please report via support channels as this indicates a code defect. Server response was: "Error message Unlock"'
      expect(session.messages.success).toEqual null

  describe 'Confirm:', () ->
    it 'success 204', () ->
      $httpBackend.expect('POST', 'sessions/confirmation.json', '{"user":{"email":"test@example.com"}}').respond 204, ''
      sessionRequest.confirm emailFake
      $httpBackend.flush()
      expect(session.messages.error).toEqual null
      expect(session.messages.success).toEqual 'A new confirmation link has been sent to your e-mail address.'

    it 'fail 401', () ->
      $httpBackend.expect('POST', 'sessions/confirmation.json', '{"user":{"email":"test@example.com"}}').respond 401, 'Error message Confirm'
      sessionRequest.confirm emailFake
      $httpBackend.flush()
      expect(session.messages.error).toEqual 'Unexplained error, potentially a server error, please report via support channels as this indicates a code defect. Server response was: "Error message Confirm"'
      expect(session.messages.success).toEqual null

  describe 'Password reset:', () ->
    it 'success 204', () ->
      $httpBackend.expect('POST', 'sessions/password.json', '{"user":{"email":"test@example.com"}}').respond 204, ''
      sessionRequest.reset_password emailFake
      $httpBackend.flush()
      expect(session.messages.error).toEqual null
      expect(session.messages.success).toEqual 'Reset instructions have been sent to your e-mail address.'

    it 'fail 401', () ->
      $httpBackend.expect('POST', 'sessions/password.json', '{"user":{"email":"test@example.com"}}').respond 401, 'Error message Password reset'
      sessionRequest.reset_password emailFake
      $httpBackend.flush()
      expect(session.messages.error).toEqual 'Unexplained error, potentially a server error, please report via support channels as this indicates a code defect. Server response was: "Error message Password reset"'
      expect(session.messages.success).toEqual null

  describe 'Register:', () ->
    it 'success 204', () ->
      $httpBackend
        .expect('POST', 'sessions/users.json', '{"user":{"name":"User test","email":"test@example.com","password":"apassword","password_confirmation":"apassword"}}')
        .respond 204,
          name: "User test"
          email: "test@example.com"

      userObject =
        name: 'User test'
        email: 'test@example.com'
        password: 'apassword'
        password_confirmation: 'apassword'

      sessionRequest.register userObject

      $httpBackend.flush()
      expect(session.logged).toBe isLogged
      expect(session.user).toEqualData
        name: "User test"
        email: "test@example.com"
      expect(session.messages.error).toEqual null
      expect(session.messages.success).toEqual 'You have been registered and logged in. A confirmation e-mail has been sent to your e-mail address, your access will terminate in 2 days if you do not use the link in that e-mail.'

    it 'fail 401', () ->
      $httpBackend
        .expect('POST', 'sessions/users.json', '{"user":{"name":"User test","email":"test@example.com","password":"apassword","password_confirmation":"apassword"}}')
        .respond 401, 'Error message register'

      userObject =
        name: 'User test'
        email: 'test@example.com'
        password: 'apassword'
        password_confirmation: 'apassword'

      sessionRequest.register userObject

      $httpBackend.flush()
      expect(session.messages.error).toEqual 'Unexplained error, potentially a server error, please report via support channels as this indicates a code defect. Server response was: "Error message register"'
      expect(session.messages.success).toEqual null

  describe 'Change password:', () ->
    it 'success 204', () ->
      $httpBackend
        .expect('PUT', 'sessions/password.json', '{"user":{"email":"test@example.com","password":"apassword","password_confirmation":"apassword"}}')
        .respond(204, '')

      email = 'test@example.com'
      password = "apassword"
      passwordConfirmation = "apassword"
      sessionRequest.change_password email, password, passwordConfirmation

      $httpBackend.flush()
      expect(session.messages.error).toEqual null
      expect(session.messages.success).toEqual 'Your password has been updated.'

    it 'fail 401', () ->
      $httpBackend
        .expect('PUT', 'sessions/password.json', '{"user":{"email":"test@example.com","password":"apassword","password_confirmation":"apassword"}}')
        .respond 401, 'Error message change password'

      email = 'test@example.com'
      password = "apassword"
      passwordConfirmation = "apassword"
      sessionRequest.change_password email, password, passwordConfirmation

      $httpBackend.flush()
      expect(session.messages.error).toEqual 'Unexplained error, potentially a server error, please report via support channels as this indicates a code defect. Server response was: "Error message change password"'
      expect(session.messages.success).toEqual null
