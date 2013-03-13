# Minimum heap.
class Heap
	constructor: (dataToHeapify = []) ->
		@_data = dataToHeapify
		# Use 1-indexed array. Simpler for calculating parent, leftChild and rightChild.
		# Unshift null to the first position
		@_data.push @_data[0]
		@_data[0] = null
		if @_data.length > 1 then @_upHeap i for i in [2...@_data.length]

	add: (value) ->
		@_data.push(value)
		@_upHeap(@_data.length - 1)
		return value

	removeMin: ->
		min = @_data[1]
		return undefined if @_data.length is 1
		return @_data.pop() if @_data.length is 2
		@_data[1] = @_data.pop()
		@_downHeap()
		return min

	peekMin: -> @_data[1]

	_upHeap: (index) ->
		valueHolder = @_data[index];
		# Make undefined and null values stay at bottom.
		if not @_data[index]? then @_data[index] = Infinity
		while (@_data[index] < @_data[_parent index] or not @_data[_parent index]?) and index > 1
			[@_data[index], @_data[_parent index]] = [@_data[_parent index], @_data[index]]
			index = _parent index
		@_data[index] = valueHolder

	_downHeap: ->
		currentIndex = 1
		valueHolder = @_data[1]
		# Trickle down undefined and null values.
		if not @_data[1]? then @_data[1] = Infinity
		while _leftChild currentIndex < @_data.length # There's a left child.
			smallerChild = _leftChild currentIndex
			if smallerChild < @_data.length - 1 # There's a right child.
				# Choose right child if it's smaller or if left child is of value undefined/null.
				if @_data[_rightChild currentIndex] < @_data[smallerChild] or not @_data[smallerChild]?
					smallerChild = _rightChild currentIndex
			if @_data[smallerChild] < @_data[currentIndex]
				[@_data[smallerChild], @_data[currentIndex]] = [@_data[currentIndex], @_data[smallerChild]]
				currentIndex = smallerChild
			else
				@_data[currentIndex] = valueHolder
				break

_parent = (index) -> index >> 1 # Fast divide by 2 then flooring.
_leftChild = (index) -> index << 1 # Fast multiply by 2.
_rightChild = (index) -> (index << 1) + 1

module.exports = Heap

