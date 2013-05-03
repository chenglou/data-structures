###
Arrays under the hood. The slow operation is `array.shift()`, at O(n). Emulate a
queue using two array stacks. Enqueue = push on stack1. Dequeue: if stack2 is
empty, dump stack1 reversed onto it, then pop; else, pop stack2.
###
class Queue
	constructor: (initialArray = []) ->
		@_stack1 = initialArray
		@_stack2 = []
		@length = initialArray.length

	enqueue: (item) ->
		@_stack1.push item
		@length++
		return item

	dequeue: ->
		if @_stack2.length is 0
			while @_stack1.length isnt 0
				@_stack2.push @_stack1.pop()
		if @_stack2.length isnt 0 then @length--
		@_stack2.pop()

	peek: ->
		if @_stack2.length is 0 then @_stack1[0]
		else @_stack2[@_stack2.length - 1]

module.exports = Queue
