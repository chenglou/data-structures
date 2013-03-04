jasmine = require 'jasmine-node'
Queue = require '../Queue'

describe "Create queue", ->
	queue = new Queue()
	it "creates a queue with length 0", ->
		expect(queue.length).toBe(0)
	xit "should be empty in the beginning", ->
		expect(queue.peek()).toBeUndefined()

describe "Enqueue, dequeue and peek", ->
	queue = new Queue()
	it "should do the operations correctly and in order, with the right length", ->
		expect(queue.enqueue("item")).toBe("item")
		expect(queue.peek()).toBe("item")
		expect(queue.length).toBe(1)

		expect(queue.dequeue()).toBe("item")
		expect(queue.peek()).toBeUndefined()
		expect(queue.length).toBe(0)

		expect(queue.enqueue("item0")).toBe("item0")
		expect(queue.peek()).toBe("item0")
		expect(queue.length).toBe(1)

		expect(queue.enqueue(1)).toBe(1)
		expect(queue.peek()).toBe("item0")
		expect(queue.length).toBe(2)

		expect(queue.enqueue([1, 2, 3])).toEqual([1, 2, 3])
		expect(queue.peek()).toEqual("item0")
		expect(queue.length).toBe(3)

		expect(queue.dequeue()).toBe("item0")
		expect(queue.peek()).toBe(1)
		expect(queue.length).toBe(2)

		expect(queue.dequeue()).toBe(1)
		expect(queue.peek()).toEqual([1, 2, 3])
		expect(queue.length).toBe(1)

		expect(queue.enqueue("")).toBe("")
		expect(queue.peek()).toEqual([1, 2, 3])
		expect(queue.length).toBe(2)

		expect(queue.dequeue()).toEqual([1, 2, 3])
		expect(queue.peek()).toBe("")
		expect(queue.length).toBe(1)

		expect(queue.dequeue()).toEqual("")
		expect(queue.peek()).toBeUndefined()
		expect(queue.length).toBe(0)
	it "should have the correct length when doing empty dequeue", ->
		expect(queue.dequeue()).toBeUndefined()
		expect(queue.length).toBe(0)

describe "ToString", ->
	queue = new Queue()
	expect(queue.toString()).toBe("")
	queue.enqueue(1)
	queue.enqueue("hi")
	queue.enqueue([1, 2, 3])
	queue.enqueue(undefined)
	queue.enqueue({"name": "Steve"})
	expect(queue.toString()).toBe("1,hi,1,2,3,,[object Object]")

xdescribe "Private members", ->
	queue = new Queue()
	it "shouldn't be accessible", ->
		expect(queue._length).toBeUndefined()
		expect(queue._content).toBeUndefined()
		expect(queue._dequeueIndex).toBeUndefined()
