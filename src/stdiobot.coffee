readline = require 'readline'
Bot = require './bot'
Mirror = require './mirror'

class _StdioMirror extends Mirror
	constructor: (@prefix) ->
		super

	inputMatches: (line) ->
		return line.startsWith @prefix + '|'

	inputToMessage: (line) ->
		splitLine = line.split '|', 2
		if splitLine.length < 2
			splitLine.unshift ''
		[prefix, text] = splitLine
		Promise.resolve {
			sender: 'Stdio Tester',
			text: text,
		}

	sendMirrored: (message) ->
		console.log @prefix + '|' + message.sender + ': ' + message.text

module.exports = class StdioBot extends Bot
	constructor: ->
		super
		@_rli = readline.createInterface {
			input: process.stdin,
			output: process.stdout,
			prompt: 'mirror-pool> ',
		}
		@_rli.on 'line', (line) =>
			@mirrorInput line
			@_rli.prompt()
		@_rli.prompt()

	createMirrorCore: (prefix) ->
		Promise.resolve new _StdioMirror prefix
