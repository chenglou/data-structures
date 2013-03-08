jasmine = require 'jasmine-node'
Graph = require '../Graph'

# Shorthand for logging
l = (x) -> console.log require('util').inspect(x, true, 10)

describe "Create graph", ->
	graph = new Graph()
	it "should create a graph with empty nodes object", -> 
		expect(graph.nodes).toEqual {}

describe "Add node", ->
	graph = new Graph()
	it "should return the value", ->
		expect(graph.add("item")).toBe "item"
		# expect(graph.add(1)).toBe 1
		expect(graph.add("1")).toBe "1"
		expect(graph.add(undefined)).toBeUndefined()
	it "should store the nodes correctly", ->
		expect(graph.nodes["item"].value).toBe "item"
		expect(graph.nodes["1"].value).toBe "1"
		# expect(graph.nodes[1].value).toBe 1
		expect(graph.nodes[undefined].value).toBeUndefined()
