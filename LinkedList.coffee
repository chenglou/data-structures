Node = (value) ->
	@value = value
	@next = undefined

LinkedList = ->
	@head = undefined
	@length = 0

LinkedList.prototype.add = (value, position = @length) ->
	if position < 0 or position > @length then return
	nodeToAdd = new Node(value)
	if position is 0
		# If list empty, old @head is undefined
		[@head, nodeToAdd.next] = [nodeToAdd, @head]
	else
		currentNode = @head
		# Get to the node before the insertion position.
		for i in [0...position - 1]
			currentNode = currentNode.next
		[currentNode.next, nodeToAdd.next] = [nodeToAdd, currentNode.next]
	@length++
	return nodeToAdd.value

LinkedList.prototype.remove = (position = @length - 1) ->
	if @length is 0 or position < 0 or position >= @length then return
	if @length is 1 or position is 0
		nodeToRemove = @head
		# In the case of length === 1, @head.next is undefined
		@head = @head.next
	else
		currentNode = @head
		# Get to the node before the removing position.
		for i in [0...position - 1]
			currentNode = currentNode.next
		nodeToRemove = currentNode.next
		currentNode.next = nodeToRemove.next
		nodeToRemove.next = undefined
	@length--
	return nodeToRemove.value

LinkedList.prototype.get = (position) ->
	if position >= @length then return
	currentNode = @head
	for i in [0...position]
		currentNode = currentNode.next
	return currentNode

LinkedList.prototype.indexOf = (value) ->
	currentNode = @head
	position = 0
	while currentNode
		if currentNode.value is value then break
		currentNode = currentNode.next
		position++
	return if position is @length then -1 else position

LinkedList.prototype.toString = ->
	if not @head then return "[]"
	output = "[" + @head.value.toString()
	currentNode = @head.next
	while currentNode
		output += "," + currentNode.value.toString()
		currentNode = currentNode.next
	output += "]"
	return output

module.exports = LinkedList
