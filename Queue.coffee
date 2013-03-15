class Queue
	constructor: (initialArray = []) ->
		@_content = initialArray
		@_dequeueIndex = 0
		@length = @_content.length

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

	peek: -> @_content[@_dequeueIndex]

	toString: -> @_content.toString()

module.exports = Queue
