Node = require '../Node'

describe "Create node", ->
	node = new Node(undefined)
	it "should create a node with null value", -> 
		expect(node.value).toBeUndefined()

describe "Change value", ->
	node = new Node(5)
	it "should work", ->
		node.value = 5
		expect(node.value).toBe 5
		node.value = undefined
		expect(node.value).toBeUndefined()
