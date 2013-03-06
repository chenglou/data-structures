Node = (value) ->
	@value = value
	@outEdges = []

DirectedGraph = ->
	@vertices = {}

# TODO: maybe verify node's not already in the graph.
DirectedGraph.prototype.add = (value) ->
	nodeToAdd = new Node(value)
	@vertices[value] = nodeToAdd
	return value

DirectedGraph.prototype.remove = (value) ->
	nodeToRemove = @vertices[value]
	if nodeToRemove
		@vertices[value] = nodeToRemove = undefined
	return value

module.exports = DirectedGraph