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

describe "Initialize with an array, first element to deqeue being array[0]", ->
    queue = new Queue([1, 5, 4, 6, 7, undefined, null, "hi"])
    it "should fill the queue with the parameter", ->
        expect(queue.dequeue()).toBe 1
        expect(queue.dequeue()).toBe 5
        expect(queue.dequeue()).toBe 4
        expect(queue.dequeue()).toBe 6
        expect(queue.dequeue()).toBe 7
        expect(queue.dequeue()).toBeUndefined()
        expect(queue.dequeue()).toBeNull()
        expect(queue.dequeue()).toBe "hi"
        expect(queue.dequeue()).toBeUndefined()

describe "Check for emptiness", ->
    queue = new Queue()
    it "returns true if queue's empty", ->
        expect(queue.isEmpty()).toBeTruthy()
    it "returns false if queue's not empty", ->
        queue.enqueue 5
        expect(queue.isEmpty()).toBeFalsy()
    it "returns true again after removing all the items", ->
        queue.dequeue()
        expect(queue.isEmpty()).toBeTruthy()

