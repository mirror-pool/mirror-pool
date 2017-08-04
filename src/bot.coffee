readline = require 'readline'
Mirror = require './mirror'

class _PromisedMirror
	constructor: (promise) ->
		@promise = promise.then (mirror) =>
			@mirror = mirror
		@promise.catch ->
			#Throw away any error
			#Errors should be handled through
			#the promise returned by createMirror()

	isReady: ->
		@mirror isnt undefined

module.exports = class Bot
	constructor: ->
		@_mirrors = [];

	createMirror: (args...) ->
		mirrorPromise = @createMirrorCore args...
		@_registerMirror mirrorPromise
		mirrorPromise

	createMirrorCore: ->
		#Add implementation in subclass

	_registerMirror: (mirrorPromise) ->
		@_mirrors.push new _PromisedMirror mirrorPromise

	mirrorInput: (inputArgs...) =>
		shouldContinue = true
		(shouldContinue = mirror.mirror.handleInput inputArgs...) \
		for mirror in @_mirrors \
		when shouldContinue and mirror.isReady()
