Queue = require '../Queue'

describe "Create queue", ->
	queue = new Queue()
	it "creates a queue with length 0", ->
		expect(queue.length).toBe 0
	it "should be empty in the beginning", ->
		expect(queue.peek()).toBeUndefined()

describe "Enqueue, dequeue and peek", ->
	queue = new Queue()
	it "should do the operations correctly and in order, with the right length", ->
		expect(queue.enqueue("item")).toBe "item"
		expect(queue.peek()).toBe "item"
		expect(queue.length).toBe 1

		expect(queue.dequeue()).toBe "item"
		expect(queue.peek()).toBeUndefined()
		expect(queue.length).toBe 0

		expect(queue.enqueue("item0")).toBe "item0"
		expect(queue.peek()).toBe "item0"
		expect(queue.length).toBe 1

		expect(queue.enqueue(1)).toBe 1
		expect(queue.peek()).toBe "item0"
		expect(queue.length).toBe 2

		expect(queue.enqueue([1, 2, 3])).toEqual [1, 2, 3]
		expect(queue.peek()).toEqual "item0"
		expect(queue.length).toBe 3

		expect(queue.dequeue()).toBe "item0"
		expect(queue.peek()).toBe 1
		expect(queue.length).toBe 2

		expect(queue.dequeue()).toBe 1
		expect(queue.peek()).toEqual [1, 2, 3]
		expect(queue.length).toBe 1

		expect(queue.enqueue("")).toBe ""
		expect(queue.peek()).toEqual [1, 2, 3]
		expect(queue.length).toBe 2

		expect(queue.dequeue()).toEqual [1, 2, 3]
		expect(queue.peek()).toBe ""
		expect(queue.length).toBe 1

		expect(queue.dequeue()).toEqual ""
		expect(queue.peek()).toBeUndefined()
		expect(queue.length).toBe 0
	it "should have the correct length when doing empty dequeue on a previously operated queue", ->
		expect(queue.dequeue()).toBeUndefined()
		expect(queue.length).toBe 0

describe "Two queues", ->
	queue = new Queue()
	queue2 = new Queue()
	it "shouldn't enter in conflict", ->
		queue.enqueue(1)
		expect(queue2.peek()).toBeUndefined()

describe "ToString", ->
	queue = new Queue()
	it "should print empty string for empty queue", ->
		expect(queue.toString()).toBe ""
	it "should pretty print", ->
		queue.enqueue(1)
		queue.enqueue("hi")
		queue.enqueue([1, 2, 3])
		queue.enqueue(undefined)
		queue.enqueue({"name": "Steve"})
		expect(queue.toString()).toBe "1,hi,1,2,3,,[object Object]"

		