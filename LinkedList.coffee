Node = (value) ->
	this.value = value
	this.next = undefined

LinkedList = ->
	this.head = undefined
	this.length = 0

LinkedList.prototype.add = (value, position) ->
	nodeToAdd = new Node(value)
	if position is undefined
		if this.length is 0
			this.head = nodeToAdd
		else
			currentNode = this.head
			until currentNode.next is undefined
				currentNode = currentNode.next
			currentNode.next = nodeToAdd
	else
		if position < 0 or position > this.length then return
		currentNode = this.head
		# Get to the node before the inserting position.
		# Explicit increment by 1, since [0...-1] is [0].
		for i in [0...position - 1] by 1
			currentNode = currentNode.next
		if position is 0
			oldHead = this.head
			this.head = nodeToAdd
			nodeToAdd.next = oldHead
		else
			oldCurrentNodeNext = currentNode.next
			currentNode.next = nodeToAdd
			nodeToAdd.next = oldCurrentNodeNext
	this.length++
	return nodeToAdd.value

LinkedList.prototype.remove = (position) ->
	if this.length is 0 then return
	if position is undefined
		if this.length is 1
			nodeToRemove = this.head
			this.head = undefined
		else
			currentNode = this.head
			# Get to the node before the one to remove
			until currentNode.next.next is undefined
				currentNode = currentNode.next
			nodeToRemove = currentNode.next
			currentNode.next = nodeToRemove.next
	else
		if position < 0 or position >= this.length then return
		currentNode = this.head
		if position is 0
			nodeToRemove = this.head
			this.head = nodeToRemove.next
		else
			# Get to the node before the removing position.
			# Explicit increment by 1, since [0...-1] is [0].
			for i in [0...position - 1] by 1
				currentNode = currentNode.next
			nodeToRemove = currentNode.next
			currentNode.next = nodeToRemove.next

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
