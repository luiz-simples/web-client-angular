'use strict'

describe 'Service: StatusRequest', () ->
  beforeEach module 'webClientAngularApp'

  StatusRequest = {}
  beforeEach inject (_StatusRequest_) ->
    StatusRequest = _StatusRequest_

  it 'should exist StatusRequest service.', () ->
    objExist = true
    expect(!!StatusRequest).toBe objExist

  it 'should status created is status success', () ->
    isSuccess = true
    statusCreated = 201
    expect(StatusRequest.isStatusSuccess(statusCreated)).toBe isSuccess

  it 'should status without content is status success', () ->
    isSuccess = true
    statusWithoutContent = 204
    expect(StatusRequest.isStatusSuccess(statusWithoutContent)).toBe isSuccess

  it 'Another status should not be considered successful.', () ->
    isNotSuccess = false
    anotherStatus = 501
    expect(StatusRequest.isStatusSuccess(anotherStatus)).toBe isNotSuccess

  it 'should status unprocessable entity is status error', () ->
    isError = true
    statusUnprocessableEntity = 422
    expect(StatusRequest.isStatusError(statusUnprocessableEntity)).toBe isError

  it 'Another status should considered error status.', () ->
    isError = true
    anotherStatus = 501
    expect(StatusRequest.isStatusError(anotherStatus)).toBe isError

  it 'should status created is not status error', () ->
    isNotError = false
    statusCreated = 201
    expect(StatusRequest.isStatusError(statusCreated)).toBe isNotError

  it 'should status without content is not status error', () ->
    isNotError = false
    statusWithoutContent = 204
    expect(StatusRequest.isStatusError(statusWithoutContent)).toBe isNotError
