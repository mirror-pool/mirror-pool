EventEmitter = require 'events'

module.exports = class Mirror extends EventEmitter
	handleInput: (inputArgs...) ->
		if @inputMatches inputArgs...
			@emit 'messageReceived', @inputToMessage inputArgs...
			@shouldContinue inputArgs...
		else
			true

	inputMatches: ->
		#Add implementation in subclass

	inputToMessage: ->
		#Add implementation in subclass

	shouldContinue: ->
		#Can override in subclass
		false

	sendMirrored: (message) ->
		#Add implementation in subclass
