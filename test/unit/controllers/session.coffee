'use strict'

describe 'Controller: SessionCtrl', () ->

  # load the controller's module
  beforeEach module 'webClientAngularApp'

  SessionCtrl = {}
  $httpBackend = {}
  scope = {}
  empty = null
  nameFake = "User test"
  emailFake = "email@fake.com"
  passwordFake = "passwordFake"
  requestSuccess = 204

  verifyWithoutRequest = (invalidUserData) ->
    scope.user = invalidUserData
    scope.access()
    $httpBackend.verifyNoOutstandingExpectation();
    $httpBackend.verifyNoOutstandingRequest();

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope, _$httpBackend_) ->
    scope = $rootScope.$new()
    $httpBackend = _$httpBackend_

    SessionCtrl = $controller 'SessionCtrl', {
      $scope: scope
    }

  it 'should begin with user fields empty.', () ->
    expect(scope.user).toEqual
      email: empty
      password: empty

  it 'login method should attempt to log with valid data.', () ->
    $httpBackend
        .expectPOST('sessions/sign_in.json',
          user:
            email: emailFake
            password: passwordFake
        ).respond requestSuccess,
          name: nameFake
          email: emailFake

    scope.user.email = emailFake
    scope.user.password = passwordFake
    scope.access()
    $httpBackend.flush()

  it 'login method should not try to connect with invalid email data.', () ->
    verifyWithoutRequest {email: emailFake, password: ""}
    verifyWithoutRequest {email: emailFake, password: " "}
    verifyWithoutRequest {email: emailFake, password: "    "}
    verifyWithoutRequest {email: "", password: passwordFake}
    verifyWithoutRequest {email: "123", password: passwordFake}
    verifyWithoutRequest {email: "asd@", password: passwordFake}
    verifyWithoutRequest {email: "asdasd", password: passwordFake}
    verifyWithoutRequest {email: "asd@asd", password: passwordFake}
    verifyWithoutRequest {email: "@asd.com", password: passwordFake}
    verifyWithoutRequest {email: "asdasd.asdasd", password: passwordFake}
