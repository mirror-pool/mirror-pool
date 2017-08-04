module.exports = class Pool
	constructor: (mirrors = []) ->
		@_mirrors = []
		@addMirror mirror for mirror in mirrors

	addMirror: (mirrorPromise) ->
		mirrorPromise.then (mirror) =>
			mirror.on 'messageReceived', (messagePromise) =>
				@mirrorMessage mirror, messagePromise
			@_mirrors.push mirror
		.catch ->
			#Throw away any error
			#This should've been handled when the mirror was created

	mirrorMessage: (sourceMirror, messagePromise) ->
		sendToMirror = (mirror) ->
			messagePromise.then (message) ->
				mirror.sendMirrored message
		sendToMirror mirror for mirror in @_mirrors \
		when mirror isnt sourceMirror
