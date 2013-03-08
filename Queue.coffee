class Queue
	constructor: ->
		@_content = []
		@_dequeueIndex = 0
		@length = 0

	enqueue: (item) ->
		@length++
		@_content.push(item)
		return item

	# Do not pop. Slice, when half of array is empty.
	dequeue: ->
		if @length is 0 then return
		@length--
		itemToDequeue = @_content[@_dequeueIndex]
		@_dequeueIndex++
		if @_dequeueIndex * 2 > @_content.length
			@_content = @_content.slice(@_dequeueIndex)
			@_dequeueIndex = 0
		return itemToDequeue

	peek: ->
		return @_content[@_dequeueIndex]

	toString: ->
		return @_content.toString()

module.exports = Queue
