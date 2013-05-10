###
Graph implemented as a modified incidence list. O(1) for every typical
operation, even `removeNode()` (O(1) amortized)!
###
class Graph
    constructor: () ->
        @_nodes = {}

    addNode: (id) ->
        ###
        The `id` is a unique identifier for the node, and should **not** change
        after it's added. It will be used for adding, retrieving and deleting
        related edges too.

        Note that JavaScript's object hashes the id `"2"` and `2` to the same
        key, so please stick with one single id data type for a same graph.

        _Returns:_ the node object. Feel free to attach additional custom
        properties on it for graph algorithms' needs. **Undefined if node id
        already exists**, as to avoid accidental overrides.
        ###
        # Keep the question mark. Id might be empty string or 0 (bad practice
        # through).
        if not @_nodes[id]
            @_nodes[id] =
                _id: id
                # outEdges is a collection of (toId, edge) pair, where the toId
                # key is the node id toward which the edge's directed. The value
                # edge is itself an object of the format {fromId, toId, weight}.
                # Using objects to represent nodes and edges allow additional
                # attributes to be attached.

                # inEdges work the same way.
                _outEdges: {}
                _inEdges: {}

    getNode: (id) ->
        ###
        _Returns:_ the node object. Feel free to attach additional custom
        properties on it for graph algorithms' needs.
        ###
        @_nodes[id]

    removeNode: (id) ->
        ###
        _Returns:_ the node object removed, or undefined if it didn't exist in
        the first place.
        ###
        nodeToRemove = @_nodes[id]
        if not nodeToRemove then return
        else
            delete @_nodes[id]
            # Usually, we'd remove all edges related to node too. But we can
            # amortize this from O(n) to O(1) by checking it during edge
            # retrieval instead.
            return nodeToRemove

    addEdge: (fromId, toId, weight = 1) ->
        ###
        `fromId` and `toId` are the node id specified when it was created using
        `addNode()`. `weight` is optional and defaults to 1. Ignoring it
        effectively makes this an unweighted graph. Under the hood, `weight` is
        just a normal property of the edge object.

        _Returns:_ the edge object created. Feel free to attach additional
        custom properties on it for graph algorithms' needs. **Or undefined** if
        the nodes of id `fromId` or `toId` aren't found, or if an edge already
        exists between the two nodes.
        ###

        # getEdge() will return an edge if it already exists. As a side effect,
        # it checks for edge inconsistency left behind from removeNode() and
        # clean them up. After this point, we can safely add a new edge.
        if @getEdge(fromId, toId) then return
        fromNode = @_nodes[fromId]
        toNode = @_nodes[toId]
        if not fromNode or not toNode then return
        edgeToAdd =
            _fromId: fromId
            _toId: toId
            weight: weight
        fromNode._outEdges[toId] = edgeToAdd
        toNode._inEdges[fromId] = edgeToAdd

    getEdge: (fromId, toId) ->
        ###
        _Returns:_ the edge object, or undefined if the nodes of id `fromId` or
        `toId` aren't found.
        ###
        fromNode = @_nodes[fromId]
        toNode = @_nodes[toId]
        # Amortization part. Clean the leftover from removeNode().
        if not fromNode and not toNode then return
        else if not fromNode
            if toNode._inEdges[fromId]
                delete toNode._inEdges[fromId]
                return
        else if not toNode
            if fromNode._outEdges[toId]
                delete fromNode._outEdges[toId]
                return
        else
            # Even if both nodes exist, the edge might not be valid. Ex: node A
            # removed, then a new node A inserted back.
            if not fromNode._outEdges[toId] and toNode._inEdges[fromId]
                delete toNode._inEdges[fromId]
                return
            else if not toNode._inEdges[fromId] and fromNode._outEdges[toId]
                delete fromNode._outEdges[toId]
                return
            else return fromNode._outEdges[toId]

    removeEdge: (fromId, toId) ->
        ###
        _Returns:_ the edge object removed, or undefined of edge wasn't found.
        ###
        fromNode = @_nodes[fromId]
        toNode = @_nodes[toId]
        edgeToDelete = @getEdge fromId, toId
        if not edgeToDelete then return
        delete fromNode._outEdges[toId]
        delete toNode._inEdges[fromId]
        return edgeToDelete

    getInEdgesOf: (nodeId) ->
        ###
        _Returns:_ an array of edge objects that are directed toward the node,
        or empty array if none exists.
        ###
        toNode = @_nodes[nodeId]
        if not toNode then return []
        inEdges = []
        for fromId of toNode._inEdges
            edge = @getEdge fromId, nodeId
            if edge then inEdges.push edge
        return inEdges

    getOutEdgesOf: (nodeId) ->
        ###
        _Returns:_ an array of edge objects that go out of the node, or empty
        array if none exists.
        ###
        fromNode = @_nodes[nodeId]
        if not fromNode then return []
        outEdges = []
        for toId of fromNode._outEdges
            edge = @getEdge nodeId, toId
            if edge then outEdges.push edge
        return outEdges

    getAllEdgesOf: (nodeId) ->
        ###
        **Note:** not the same as concatenating `getInEdgesOf()` and
        `getOutEdgesOf()`. Some nodes might have an edge pointing toward itself.
        This method solves that duplication.

        _Returns:_ an array of edge objects linked to the node, no matter if
        they're outgoing or coming. Duplicate edge created by self-pointing
        nodes are removed. Only one copy stays. Empty array if node has no edge.
        ###
        inEdges = @getInEdgesOf nodeId
        outEdges = @getOutEdgesOf nodeId
        if inEdges.length is 0 then return outEdges
        selfEdge = @getEdge nodeId, nodeId
        if selfEdge
            for i in [0...inEdges.length]
                if inEdges[i] is selfEdge
                    [inEdges[i], inEdges[inEdges.length - 1]] =
                    [inEdges[inEdges.length - 1], inEdges[i]]
                    inEdges.pop()
                    break
        return inEdges.concat outEdges

    forEachNode: (operation) ->
        ###
        Traverse through the graph in an arbitrary manner, visiting each node
        once. Pass a function of the form `fn(nodeObject)`.
        ###
        for nodeId, nodeObject of @_nodes
            operation nodeObject

    forEachEdge: (operation) ->
        ###
        Traverse through the graph in an arbitrary manner, visiting each edge
        once. Pass a function of the form `fn(edgeObject)`.
        ###
        for nodeId, nodeObject of @_nodes
            for toId, edgeObject of nodeObject._outEdges
                operation edgeObject

    isEmpty: ->
        ###
        _Returns:_ true or false.
        ###
        for child of @_nodes
            return no
        return yes

module.exports = Graph
