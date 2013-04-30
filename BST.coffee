# TODO: consider if remove and peek should return empty node instead of undefined.

# Binary search tree.
Node = require './Node'

NODE_FOUND = 0
NODE_TOO_BIG = -1
NODE_TOO_SMALL = 1

class treeNode extends Node
	constructor: (value) ->
		super(value)
		@parent
		@leftChild
		@rightChild

class BST
	constructor: ->
		@root

	add: (value) ->
		nodeToInsert = new treeNode(value)
		if not @root
			@root = nodeToInsert
		else
			_findNode @root, (node) ->
				if value is node.value then NODE_FOUND
				else
					if value < node.value
						if node.leftChild then NODE_TOO_BIG
						else
							nodeToInsert.parent = node
							node.leftChild = nodeToInsert
							NODE_FOUND
					# Inserting "undefined" will go to right child. Important to keep
					# this conditional in sync with find().
					else
						if node.rightChild then NODE_TOO_SMALL
						else
							nodeToInsert.parent = node
							node.rightChild = nodeToInsert
							NODE_FOUND
		return value

	find: (value) ->
		foundNode = _findNode @root, (node) ->
			if value is node.value then NODE_FOUND
			# Keep the conditional this way; node.value > value wouldn't work.
			# The insertion uses the same comparison to add "undefined" (to the right child).
			else if value < node.value then NODE_TOO_BIG
			else NODE_TOO_SMALL

	peekMinimum: ->
		_peekMinimumNode(@root)?.value

	peekMaximum: ->
		_peekMaximumNode(@root)?.value

	remove: (value) ->
		nodeToRemove = @find(value)
		if not nodeToRemove then return
		@_removeNode(@root, nodeToRemove)
		return value

	removeMinimum: ->
		nodeToRemove = _peekMinimumNode(@root)
		if not nodeToRemove then return
		# Store in. Might destroy the node during removal in the future, so can't just return nodeToRemove.value.
		valueToReturn = nodeToRemove.value
		@_removeNode(@root, nodeToRemove)
		return valueToReturn

	removeMaximum: ->
		nodeToRemove = _peekMaximumNode(@root)
		if not nodeToRemove then return
		# Store in. Might destroy the node during removal in the future, so can't just return nodeToRemove.value.
		valueToReturn = nodeToRemove.value
		@_removeNode(@root, nodeToRemove)
		return valueToReturn

	_removeNode: (root, node) ->
		# Leaf.
		if not node.leftChild and not node.rightChild
			if node is @root then @root = undefined
			else
				node.parent[_leftOrRightChild(node)] = undefined
				node.parent = undefined
		# Internal node with two children.
		else if node.leftChild and node.rightChild
			# In-order successor. Left-most child of right subtree.
			# Or in-order precessor. Right-most child of left subtree.
			successor = _peekMinimumNode(node.rightChild) or _peekMaximumNode(node.leftChild)
			# Not really swapping, but same result.
			node.value = successor.value
			# Remove successor and join its parent and its child. Only one or zero.
			successor.leftChild?.parent = successor.parent
			successor.rightChild?.parent = successor.parent
			successor.parent?[_leftOrRightChild(successor)] = successor.leftChild or successor.rightChild
			# successor is now detached
		# Internal node with one child.
		else
			successor = node.leftChild or node.rightChild
			# Not really swapping, but same result.
			node.value = successor.value
			# Remove node and join its parent and its children.
			successor.leftChild?.parent = node
			successor.rightChild?.parent = node

			node.leftChild = successor.leftChild
			node.rightChild = successor.rightChild
			# successor is now detached

			# Alt version:
			# successor = node.leftChild or node.rightChild
			# if node is @root then @root = successor
			# successor.parent = node.parent
			# node.parent?[_leftOrRightChild node] = successor

_leftOrRightChild = (node) ->
	# No need to check if parent exist. It's never used this way.
	if node is node.parent.leftChild then "leftChild" else "rightChild"

_findNode = (startingNode, comparator) ->
	currentNode = startingNode
	foundNode = undefined
	while currentNode
		comparisonResult = comparator(currentNode)
		if comparisonResult is NODE_FOUND
			foundNode = currentNode
			break
		if comparisonResult is NODE_TOO_BIG
			currentNode = currentNode.leftChild
		else
			currentNode = currentNode.rightChild
	return foundNode

_peekMinimumNode = (startingNode) ->
	_findNode startingNode, (node) ->
		if node.leftChild then NODE_TOO_BIG else NODE_FOUND

_peekMaximumNode = (startingNode) ->
	_findNode startingNode, (node) ->
		if node.rightChild then NODE_TOO_SMALL else NODE_FOUND

module.exports = BST

