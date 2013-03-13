Heap = require '../Heap'

# Shorthand for logging tree
l = (x) -> console.log require('util').inspect(x, true, 10)

removeAllMins = (heap, outputContainer) ->
	for i in [0..10]
		min = heap.peekMin()
		outputContainer[i] = removedMin = heap.removeMin()
		expect(removedMin).toBe min

describe "Add, peek minimum and remove it", ->
	heap = new Heap()
	it "should return undefined if minimum is not found (heap empty)", ->
		expect(heap.peekMin()).toBeUndefined()
		expect(heap.removeMin()).toBeUndefined()
	it "should return the value added, even negative and undefined ones", ->
		expect(heap.add(-1)).toBe -1
		expect(heap.add(0)).toBe 0
		expect(heap.add(-2)).toBe -2
		heap.add(undefined)
		heap.add(-10)
		heap.add(4)
		heap.add(9)
		heap.add(99)
		heap.add(-6)
		heap.add(8)
		heap.add(7)
	it "should have the correct minimum", ->
		output = []
		removeAllMins(heap, output)
		expect(output).toEqual [-10, -6, -2, -1, 0, 4, 7, 8, 9, 99, undefined]		
	heap2 = new Heap([undefined, 4, 6, -8, null, 5, -3, 2, 5, 6, -7])
	it "should initialize a heap if an array is passed", ->
		output = []
		removeAllMins(heap2, output)
		expect(output).toEqual [-8, -7, -3, 2, 4, 5, 5, 6, 6, null, undefined]		
