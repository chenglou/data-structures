Queue = ->
	@content = []
	@length = 0
	@dequeueIndex = 0

Queue.prototype.enqueue = (item) ->
	@length++
	@content.push(item)
	return item

Queue.prototype.dequeue = ->
	if @length is 0 then return
	@length--
	itemToDequeue = @content[@dequeueIndex]
	@dequeueIndex++
	if @dequeueIndex * 2 > @content.length
		@content = @content.slice(@dequeueIndex)
		@dequeueIndex = 0
	return itemToDequeue

Queue.prototype.peek = ->
	return @content[@dequeueIndex]

Queue.prototype.toString = ->
	return @content.toString()

module.exports = Queue
