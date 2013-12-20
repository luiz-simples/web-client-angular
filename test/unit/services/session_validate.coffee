'use strict'

describe 'Service: SessionValidate', () ->
  beforeEach ->
    @addMatchers toEqualData: (expected) ->
      angular.equals @actual, expected

  beforeEach module 'webClientAngularApp'

  # instantiate service
  validate = {}
  stringEmpty = true
  stringFilled = false
  emailValid = true
  emailInvalid = false
  validUser = true

  beforeEach inject (_SessionValidate_) ->
    validate = _SessionValidate_

  it 'should exist service', () ->
    objExist = true
    expect(!!validate).toBe objExist

  describe 'isEmail: ', () ->
    it 'should return invalid if email without @', () ->
      expect(validate.isEmail("teste.com.br")).toBe emailInvalid

    it 'should return invalid if no letters before the @', () ->
      expect(validate.isEmail("@teste.com.br")).toBe emailInvalid

    it 'should return invalid if no letters after the @', () ->
      expect(validate.isEmail("ass@")).toBe emailInvalid

    it 'should return invalid if no letters after the @', () ->
      expect(validate.isEmail("ass@")).toBe emailInvalid

    it 'should return invalid if email empty', () ->
      expect(validate.isEmail("")).toBe emailInvalid

    it 'should return valid if email with one point', () ->
      expect(validate.isEmail("user@teste.com")).toBe emailValid

    it 'should return valid if email without point', () ->
      expect(validate.isEmail("user@teste")).toBe emailInvalid

    it 'should return valid if email with two points', () ->
      expect(validate.isEmail("user@teste.com.br")).toBe emailValid

    it 'should return invalid if email is null', () ->
      expect(validate.isEmail(null)).toBe emailInvalid

    it 'should return invalid if email is undefined', () ->
      expect(validate.isEmail(undefined)).toBe emailInvalid

  describe 'isEmpty: ', () ->
    it 'should return true if string is empty', () ->
      expect(validate.isEmpty("")).toBe stringEmpty

    it 'should return true if string is empty', () ->
      expect(validate.isEmpty("ASD")).toBe stringFilled

    it 'should return true if string is filled', () ->
      expect(validate.isEmpty("User teste String not Empty")).toBe stringFilled

    it 'should return true if string contains only white spaces', () ->
      expect(validate.isEmpty("    ")).toBe stringEmpty

    it 'should return true if string is null', () ->
      expect(validate.isEmpty(null)).toBe stringEmpty

    it 'should return true if string is undefined', () ->
      expect(validate.isEmpty(undefined)).toBe stringEmpty

  describe 'isValidUserObject: ', () ->
    it 'should return true when an object with name and valid email', () ->
      userValid =
        name: "User Valid"
        email: "teste@email.com.br"

      validate.isValidUserObject userValid
      , (data) ->
        expect(data).toEqualData
          name: "User Valid"
          email: "teste@email.com.br"

      , (data) ->
        expect(true).toBe false

    it 'should return false when an object with invalid email', () ->
      userValid =
        name: "User Valid"
        email: "invalid_email"

      validate.isValidUserObject userValid
      , (data) ->
        expect(true).toBe false

      , (data) ->
        expect(data).toEqualData
          name: "User Valid"
          email: "invalid_email"

    it 'should return false when an object with empty email', () ->
      userValid =
        name: "User Valid"
        email: ""

      validate.isValidUserObject userValid
      , (data) ->
        expect(true).toBe false

      , (data) ->
        expect(data).toEqualData
          name: "User Valid"
          email: ""

    it 'should return false when an object with empty name', () ->
      userValid =
        name: ""
        email: "teste@email.com.br"

      validate.isValidUserObject userValid
      , (data) ->
        expect(true).toBe false

      , (data) ->
        expect(data).toEqualData
          name: ""
          email: "teste@email.com.br"
