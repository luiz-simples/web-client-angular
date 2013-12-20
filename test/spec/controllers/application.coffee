'use strict'

describe 'Controller: ApplicationCtrl', () ->

  # load the controller's module
  beforeEach module 'webClientAngularApp'

  ApplicationCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    ApplicationCtrl = $controller 'ApplicationCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
