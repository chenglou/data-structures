LinkedList = require '../LinkedList'
	
describe "Create new linked list", ->
	linkedList = new LinkedList()
	it "should have length initialized to 0", ->
		expect(linkedList.length).toBe 0
	it "should have head initialized to null", ->
		expect(linkedList.head).toBeUndefined()

describe "Add node", ->
	describe "at the end", ->
		linkedList = new LinkedList()
		it "should add to the head when the list's empty", ->
			expect(linkedList.add("item0")).toBe "item0"
			expect(linkedList.head.value).toBe "item0"
			expect(linkedList.head.next).toBeUndefined()
		it "should add items in order", ->
			expect(linkedList.add("item1")).toBe "item1"
			expect(linkedList.add("item2")).toBe "item2"
			expect(linkedList.add("item3")).toBe "item3"

			expect(linkedList.head.value).toBe "item0"
			expect(linkedList.head.next.value).toBe "item1"
			expect(linkedList.head.next.next.value).toBe "item2"
			expect(linkedList.head.next.next.next.value).toBe "item3"
			expect(linkedList.head.next.next.next.next).toBeUndefined()
			
	describe "using offset", ->
		linkedList = new LinkedList()
		it "should add to the head when the list's empty", ->
			expect(linkedList.add(0, 0)).toBe 0
			expect(linkedList.head.value).toBe 0
			expect(linkedList.head.next).toBeUndefined()
		it "should insert a new first item correctly", ->
			expect(linkedList.add(-1, 0)).toBe -1
			expect(linkedList.head.value).toBe -1
			expect(linkedList.head.next.value).toBe 0
			expect(linkedList.head.next.next).toBeUndefined()
		it "should add more items in the correct order", ->
			expect(linkedList.add(-0.5, 1)).toBe -0.5
			expect(linkedList.add(1, 3)).toBe 1

			expect(linkedList.head.value).toBe -1
			expect(linkedList.head.next.value).toBe -0.5
			expect(linkedList.head.next.next.value).toBe 0
			expect(linkedList.head.next.next.next.value).toBe 1
			expect(linkedList.head.next.next.next.next).toBeUndefined()
		it "should return undefined when the add is invalid", ->
			expect(linkedList.add("item0", -1)).toBeUndefined()
			expect(linkedList.add("item0", 99)).toBeUndefined()
		it "should not modify linked list after invalid adds", ->
			expect(linkedList.head.value).toBe -1
			expect(linkedList.head.next.value).toBe -0.5
			expect(linkedList.head.next.next.value).toBe 0
			expect(linkedList.head.next.next.next.value).toBe 1
			expect(linkedList.head.next.next.next.next).toBeUndefined()

describe "Remove node", ->
	describe "from the end", ->
		linkedList = new LinkedList()
		it "should work on non-empty list", ->
			linkedList.add("item0")
			linkedList.add("item1")
			linkedList.add("item2")
			expect(linkedList.remove()).toBe "item2"
			expect(linkedList.head.value).toBe "item0"
			expect(linkedList.head.next.value).toBe "item1"
			expect(linkedList.head.next.next).toBeUndefined()
			expect(linkedList.remove()).toBe "item1"
			expect(linkedList.head.value).toBe "item0"
			expect(linkedList.head.next).toBeUndefined()
			expect(linkedList.remove()).toBe "item0"
			expect(linkedList.head).toBeUndefined()
		it "should not error when removing empty linked list", ->
			expect(linkedList.remove()).toBeUndefined()

	describe "using offset", ->
		linkedList = new LinkedList()
		it "should remove the right item", ->
			linkedList.add("item0")
			linkedList.add("item1")
			linkedList.add("item2")
			linkedList.add("item3")
			expect(linkedList.remove(1)).toBe "item1"
			expect(linkedList.head.value).toBe "item0"
			expect(linkedList.head.next.value).toBe "item2"
			expect(linkedList.head.next.next.value).toBe "item3"
			expect(linkedList.head.next.next.next).toBeUndefined()
			expect(linkedList.remove(0)).toBe "item0"
			expect(linkedList.head.value).toBe "item2"
			expect(linkedList.head.next.value).toBe "item3"
			expect(linkedList.head.next.next).toBeUndefined()
			expect(linkedList.remove(1)).toBe "item3"
			expect(linkedList.head.value).toBe 'item2'
			expect(linkedList.head.next).toBeUndefined()
			expect(linkedList.remove(0)).toBe "item2"
			expect(linkedList.head).toBeUndefined()
		linkedList2 = new LinkedList()
		it "should return undefined when the remove is invalid", ->
			linkedList2.add("i0")
			linkedList2.add("i1")
			expect(linkedList2.remove(99)).toBeUndefined()
			expect(linkedList2.remove(-1)).toBeUndefined()
		it "should not modify linked list after invalid removes", ->
			expect(linkedList2.head.value).toBe "i0"
			expect(linkedList2.head.next.value).toBe "i1"
			expect(linkedList2.head.next.next).toBeUndefined()

describe "Get node", ->
	linkedList = new LinkedList()
	it "should return undefined for invalid node", ->
		expect(linkedList.get(0)).toBeUndefined()
		linkedList.add("item0")
		linkedList.add("item1")
		expect(linkedList.get(2)).toBeUndefined()
	it "should return the value for a valid node", ->
		expect(linkedList.get(0).value).toBe "item0"
		expect(linkedList.get(1).value).toBe "item1"

describe "indexOf", ->
	linkedList = new LinkedList()
	array = [1, 2, 3]
	it "returns -1 if the item isn't found", ->
		linkedList.add("hello")
		linkedList.add(-1)
		linkedList.add([1, 2, 3])
		linkedList.add(array)
		linkedList.add(10)
		linkedList.add(10)
		linkedList.add("")
		expect(linkedList.indexOf([1, 2, 3])).toBe -1
		expect(linkedList.indexOf(99)).toBe -1
	it "returns the index of the item found", ->
		expect(linkedList.indexOf("hello")).toBe 0
		expect(linkedList.indexOf(-1)).toBe 1
		expect(linkedList.indexOf(array)).toBe 3
		expect(linkedList.indexOf(10)).toBe 4
		expect(linkedList.indexOf("")).toBe 6
	linkedList2 = new LinkedList()
	it "shouldn't find anything in an empty linked list", ->
		expect(linkedList2.indexOf("")).toBe -1
		expect(linkedList2.indexOf("hello")).toBe -1
		expect(linkedList2.indexOf(undefined)).toBe -1

describe "Get length", ->
	# Initialized value to 0 already tested
	linkedList = new LinkedList()
	it "should return the correct value", ->
		linkedList.add(0)
		expect(linkedList.length).toBe 1
		linkedList.add(0.5, 99)
		expect(linkedList.length).toBe 1
		linkedList.add(0.5, 1)
		expect(linkedList.length).toBe 2
		linkedList.remove()
		expect(linkedList.length).toBe 1
		linkedList.remove(99)
		expect(linkedList.length).toBe 1
		linkedList.remove()
		expect(linkedList.length).toBe 0

describe "ToString", ->
	linkedList = new LinkedList()
	it "should pretty print", ->
		linkedList.add("asd")
		linkedList.add(1)
		linkedList.add([4, 5, 6])
		expect(linkedList.toString()).toBe "[asd,1,4,5,6]"

