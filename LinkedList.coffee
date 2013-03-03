Node = (value) ->
	this.value = value
	this.next = undefined

LinkedList = ->
	this.head = undefined
	this.length = 0

LinkedList.prototype.add = (value, position = this.length) ->
	if position < 0 or position > this.length then return
	nodeToAdd = new Node(value)
	if position is 0
		# If list empty, old this.head is undefined
		[this.head, nodeToAdd.next] = [nodeToAdd, this.head]
	else
		currentNode = this.head
		# Get to the node before the insertion position.
		for i in [0...position - 1]
			currentNode = currentNode.next
		[currentNode.next, nodeToAdd.next] = [nodeToAdd, currentNode.next]
	this.length++
	return nodeToAdd.value

LinkedList.prototype.remove = (position = this.length - 1) ->
	if this.length is 0 or position < 0 or position >= this.length then return
	if this.length is 1 or position is 0
		nodeToRemove = this.head
		# In the case of length === 1, this.head.next is undefined
		this.head = this.head.next
	else
		currentNode = this.head
		# Get to the node before the removing position.
		for i in [0...position - 1]
			currentNode = currentNode.next
		nodeToRemove = currentNode.next
		currentNode.next = currentNode.next.next
	this.length--
	return nodeToRemove.value

LinkedList.prototype.get = (position) ->
	if position >= this.length then return
	currentNode = this.head
	for i in [0...position]
		currentNode = currentNode.next
	return currentNode

LinkedList.prototype.indexOf = (value) ->
	currentNode = this.head
	position = 0
	while currentNode isnt undefined
		if currentNode.value is value then break
		currentNode = currentNode.next
		position++
	return if position is this.length then -1 else position

LinkedList.prototype.toString = ->
	if this.head is undefined then return "[]"
	output = "[" + this.head.value.toString()
	currentNode = this.head.next
	while currentNode isnt undefined
		output += "," + currentNode.value.toString()
		currentNode = currentNode.next
	output += "]"
	return output

module.exports = LinkedList
