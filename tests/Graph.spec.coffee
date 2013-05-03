Graph = require '../Graph'

# Shorthand for logging.
l = (x) -> console.log require('util').inspect x, true, 10

generate = (graph) ->
    graph.add "1"
    graph.add "2"
    graph.add "3"
    graph.add "4"
    graph.add "5"
    graph.add "6"

generateEdges = (graph) ->
    ###
    1 <- 2 <-> 3
    |^   ^     ^
    v \  |     |
    4   \5     6
    ###
    graph.addEdge "1", "4"
    graph.addEdge "2", "1"
    graph.addEdge "2", "3"
    graph.addEdge "3", "2"
    graph.addEdge "5", "1"
    graph.addEdge "5", "2"
    graph.addEdge "6", "3"

describe "Add and get vertex", ->
    graph = new Graph()
    it "should return the value", ->
        expect(graph.add "item").toBe "item"
        expect(graph.add "1").toBe "1"
        expect(graph.add undefined).toBeUndefined()
    it "should have created those vertices", ->
        expect(graph.get("item").value).toBe "item"
        expect(graph.get("1").value).toBe "1"
        expect(graph.get(undefined).value).toBeUndefined()
    it "should have created vertices with no edges", ->
        expect(graph.get("item").outEdges).toEqual {}
        expect(graph.get("1").outEdges).toEqual {}
        expect(graph.get(undefined).outEdges).toEqual {}
        expect(graph.get("item").inEdges).toEqual {}
        expect(graph.get("1").inEdges).toEqual {}
        expect(graph.get(undefined).inEdges).toEqual {}

describe "Add, remove and check edge between vertices", ->
    graph = new Graph()
    it "should return false if one of the vertex doesn't exist", ->
        expect(graph.addEdge "A", "B").toBeFalsy()
        expect(graph.addEdge undefined, undefined).toBeFalsy()
        expect(graph.removeEdge "A", "B").toBeFalsy()
        expect(graph.removeEdge undefined, undefined).toBeFalsy()
        expect(graph.checkForEdge "A", "B").toBeFalsy()
        expect(graph.checkForEdge undefined, undefined).toBeFalsy()
    it "should return true after adding an edge", ->
        generate graph
        expect(graph.addEdge "1", "4").toBeTruthy()
        expect(graph.addEdge "2", "1").toBeTruthy()
        expect(graph.addEdge "2", "3").toBeTruthy()
        expect(graph.addEdge "3", "2").toBeTruthy()
        expect(graph.addEdge "5", "1").toBeTruthy()
        expect(graph.addEdge "5", "2").toBeTruthy()
        expect(graph.addEdge "6", "3").toBeTruthy()
    it "should have all the edges now", ->
        expect(graph.checkForEdge "1", "4").toBeTruthy()
        expect(graph.checkForEdge "2", "1").toBeTruthy()
        expect(graph.checkForEdge "2", "3").toBeTruthy()
        expect(graph.checkForEdge "3", "2").toBeTruthy()
        expect(graph.checkForEdge "5", "1").toBeTruthy()
        expect(graph.checkForEdge "5", "2").toBeTruthy()
        expect(graph.checkForEdge "6", "3").toBeTruthy()

        expect(graph.checkForEdge "1", "2").toBeFalsy()
        expect(graph.checkForEdge "1", "5").toBeFalsy()
        expect(graph.checkForEdge "2", "5").toBeFalsy()
        expect(graph.checkForEdge "3", "6").toBeFalsy()
        expect(graph.checkForEdge "4", "1").toBeFalsy()
        expect(graph.checkForEdge "4", "5").toBeFalsy()
        expect(graph.checkForEdge "5", "6").toBeFalsy()
    it "should remove an edge correctly", ->
        expect(graph.removeEdge "1", "4").toBeTruthy()
        expect(graph.removeEdge "2", "1").toBeTruthy()
        expect(graph.removeEdge "2", "3").toBeTruthy()
        expect(graph.removeEdge "3", "2").toBeTruthy()
        expect(graph.checkForEdge "5", "2").toBeTruthy()
        expect(graph.checkForEdge "5", "1").toBeTruthy()
        expect(graph.checkForEdge "6", "3").toBeTruthy()
        expect(graph.removeEdge "5", "1").toBeTruthy()
        expect(graph.removeEdge "5", "2").toBeTruthy()
        expect(graph.removeEdge "6", "3").toBeTruthy()
    it "should leave an empty graph after removing all the edges", ->
        expect(graph.get("1").inEdges).toEqual {}
        expect(graph.get("2").inEdges).toEqual {}
        expect(graph.get("3").inEdges).toEqual {}
        expect(graph.get("4").inEdges).toEqual {}
        expect(graph.get("5").inEdges).toEqual {}
        expect(graph.get("6").inEdges).toEqual {}
        expect(graph.get("1").outEdges).toEqual {}
        expect(graph.get("2").outEdges).toEqual {}
        expect(graph.get("3").outEdges).toEqual {}
        expect(graph.get("4").outEdges).toEqual {}
        expect(graph.get("5").outEdges).toEqual {}
        expect(graph.get("6").outEdges).toEqual {}

describe "Remove vertex", ->
    graph = new Graph()
    it "should return false if the vertex doesn't exist", ->
        expect(graph.remove undefined).toBeFalsy()
        expect(graph.remove "1").toBeFalsy()
    it "should remove the vertex and all its connections", ->
        generate graph
        generateEdges graph
        expect(graph.remove "2").toBeTruthy()
        expect(graph.get "2").toBeUndefined()
        # expect(graph.checkForEdge("2", "3")).toBeFalsy()
        expect(graph.checkForEdge "3", "2").toBeFalsy()
        expect(graph.get("3").inEdges["2"]).toBeUndefined()
        expect(graph.get("3").outEdges["2"]).toBeUndefined()

describe "forEach traversal", ->
    graph = new Graph()
    it "should reach each vertex", ->
        generate graph
        i = 1
        graph.forEach (vertex) ->
            expect(vertex.value).toBe String(i++)

describe "Depth first traversal", ->
    graph = new Graph()
    it "should read nothing from an empty graph", ->
        result = ''
        graph.depthFirstTraversal (vertex) ->
            result += vertex.value
        expect(result).toEqual ''
    it "should produce the good result", ->
        generate graph
        result = ''
        graph.depthFirstTraversal (vertex) ->
            result += vertex.value
        expect(result).toBe '6'
        generateEdges graph
        result = ''
        graph.depthFirstTraversal (vertex) ->
            result += vertex.value
        expect(result).toBe '63214'
