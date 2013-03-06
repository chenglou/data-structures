jasmine = require 'jasmine-node'
DirectedGraph = require '../DirectedGraph'

describe "Create graph", ->
	directedGraph = new DirectedGraph()
	it "creates a graph with empty vertices object", ->
		expect(directedGraph.vertices).toEqual({})