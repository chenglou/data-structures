# TODO: change outEdges, inEdges and vertices to using Map
Node = require './Node'
Map = require './Map'

class Vertex extends Node
	constructor: (value) ->
		super(value)
		@outEdges = {}
		@inEdges = {}
		# For graph traversal
		@visited = no

class Graph
	constructor: ->
		@vertices = {}

# TODO: maybe verify node's not already in the graph.
Graph.prototype.add = (value) ->
	nodeToAdd = new Vertex(value)
	@vertices[value] = nodeToAdd
	return value

Graph.prototype.remove = (value) ->
	nodeToRemove = @vertices[value]
	if nodeToRemove
		@vertices[value] = nodeToRemove = undefined
	return value

Graph.prototype.addEdge = (value1, value2) ->
	node1 = @vertices[value1]
	node2 = @vertices[value2]
	if not node1 or not node2 then return
	node1.outEdges[value2] = node2
	node2.inEdges[value1] = node1

Graph.removeEdge = (value1, value2) ->
	node1 = @vertices[value1]
	node2 = @vertices[value2]
	if not node1 or not node2 then return
	delete node1.outEdges[value2]
	delete node2.inEdges[value1]

Graph.prototype.depthFirstTraversal = ->
	for key, node of @vertices
		console.log key, node

directedGraph = new Graph()
directedGraph.add("A")
directedGraph.add("B")
directedGraph.add("C")
directedGraph.addEdge("A", "B")

# directedGraph.depthFirstTraversal()

module.exports = Graph