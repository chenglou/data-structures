# TODO: give option for weighted / non-directed
Node = require './Node'

class Vertex extends Node
	constructor: (value) ->
		super(value)
		@outEdges = {}
		@inEdges = {}
		# For graph traversal
		@visited = no

class Graph
	constructor: ->
		@_vertices = {}

	# TODO: maybe verify node's not already in the graph.
	add: (value) ->
		@_vertices[value] = new Vertex(value)
		return value

	get: (value) ->
		@_vertices[value]

	remove: (value) ->
		if @_vertices[value]
			vertexToRemove = @_vertices[value]
			for inValue, inVertex of vertexToRemove.inEdges
				delete inVertex.outEdges[value]
			for outValue, outVertex of vertexToRemove.outEdges
				delete outVertex.inEdges[value]
			delete @_vertices[value]
			return true
		return false

	addEdge: (fromValue, toValue) ->
		fromVertex = @_vertices[fromValue]
		toVertex = @_vertices[toValue]
		if not fromVertex or not toVertex then return false
		fromVertex.outEdges[toValue] = toVertex
		toVertex.inEdges[fromValue] = fromVertex
		return true

	removeEdge: (fromValue, toValue) ->
		fromVertex = @_vertices[fromValue]
		toVertex = @_vertices[toValue]
		if not fromVertex or not toVertex then return false
		delete fromVertex.outEdges[toValue]
		delete toVertex.inEdges[fromValue]
		return true

	checkForEdge: (fromValue, toValue) ->
		# Check in both vertices. Inconsistency means bug.
		fromVertex = @_vertices[fromValue]
		toVertex = @_vertices[toValue]
		if not fromVertex or not toVertex then return no
		return fromVertex.outEdges[toValue] and toVertex.inEdges[fromValue]

	forEach: (operationOnVertex) ->
		for value, vertex of @_vertices
			operationOnVertex(vertex)

	depthFirstTraversal: (operationOnVertex) ->
		# Clean up first.
		randomVertex
		for value, vertex of @_vertices
			vertex.visited = no
			randomVertex = vertex
		if randomVertex then _traversalPostCleanUp(randomVertex, operationOnVertex)

_traversalPostCleanUp = (vertex, operationOnVertex) ->
	vertex.visited = yes
	operationOnVertex(vertex)
	for outValue, outVertex of vertex.outEdges
		if not outVertex.visited
			_traversalPostCleanUp(outVertex, operationOnVertex)

module.exports = Graph



