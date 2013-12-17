#global describe, expect, it
"use strict"

protractor = require 'protractor'
by_ = protractor.By

describe "angularjs homepage", ->
  it "should greet the named user", ->
    browser.get "http://www.angularjs.org"
    element(by_.model("yourName")).sendKeys "Julie"
    greeting = element(by_.binding("yourName"))
    expect(greeting.getText()).toEqual "Hello Julie!"

  describe "todo list", ->
    todoList = undefined
    beforeEach ->
      browser.get "http://www.angularjs.org"
      todoList = element.all(by_.repeater("todo in todos"))

    it "should list todos", ->
      expect(todoList.count()).toEqual 2
      expect(todoList.get(1).getText()).toEqual "build an angular app"

    it "should add a todo", ->
      addTodo = element(by_.model("todoText"))
      addButton = element(by_.css("[value=\"add\"]"))
      addTodo.sendKeys "write a protractor test"
      addButton.click()
      expect(todoList.count()).toEqual 3
      expect(todoList.get(2).getText()).toEqual "write a protractor test"
