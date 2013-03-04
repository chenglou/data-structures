Queue = ->
	@_content = []
	@length = 0
	@_dequeueIndex = 0

Queue.prototype.enqueue = (item) ->
	@length++
	@_content.push(item)
	return item

Queue.prototype.dequeue = ->
	if @length is 0 then return
	@length--
	itemToDequeue = @_content[@_dequeueIndex]
	@_dequeueIndex++
	if @_dequeueIndex * 2 > @_content.length
		@_content = @_content.slice(@_dequeueIndex)
		@_dequeueIndex = 0
	return itemToDequeue

Queue.prototype.peek = ->
	return @_content[@_dequeueIndex]

Queue.prototype.toString = ->
	return @_content.toString()

module.exports = Queue
