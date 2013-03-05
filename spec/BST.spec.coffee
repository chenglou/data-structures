jasmine = require 'jasmine-node'
BST = require '../BST'

# Shorthand for logging tree
l = (x) -> console.log require('util').inspect(x, true, 10)

fillBalancedTree = (bst) ->
	###
				8
		3				10
	1		6				14
		4		7		13
	###
	bst.add(8)
	bst.add(3)
	bst.add(10)
	bst.add(1)
	bst.add(6)
	bst.add(14)
	bst.add(4)
	bst.add(7)
	bst.add(13)

describe "Creation", ->
	bst = new BST()
	it "should make an empty root", ->
		expect(bst.root).toBeUndefined()

describe "Insert", ->
	bst = new BST()
	it "should return the node value", ->
		expect(bst.add(1)).toBe(1)
		expect(bst.add(undefined)).toBeUndefined()
		expect(bst.add("item")).toBe("item")
	bst2 = new BST()
	it "should add the first node as the root", ->
		bst2.add(8)
		expect(bst2.root.value).toBe(8)
		expect(bst2.root.parent).toBeUndefined()
		expect(bst2.root.leftChild).toBeUndefined()
		expect(bst2.root.rightChild).toBeUndefined()
	it "should add a node as left child of root", ->
		bst2.add(3)
		expect(bst2.root.leftChild.value).toBe(3)
		expect(bst2.root.leftChild.parent.value).toBe(8)
	it "should add a node as right child of root", ->
		bst2.add(10)
		expect(bst2.root.rightChild.value).toBe(10)
		expect(bst2.root.rightChild.parent.value).toBe(8)
	it "should add 6 as 3's right child", ->
		bst2.add(6)
		expect(bst2.root.leftChild.rightChild.value).toBe(6)
		expect(bst2.root.leftChild.rightChild.parent.value).toBe(3)
	it "should add 14 as 10's right child", ->
		bst2.add(14)
		expect(bst2.root.rightChild.rightChild.value).toBe(14)
		expect(bst2.root.rightChild.rightChild.parent.value).toBe(10)
	it "should add 4 as 6's left child", ->
		bst2.add(4)
		expect(bst2.root.leftChild.rightChild.leftChild.value).toBe(4)
		expect(bst2.root.leftChild.rightChild.leftChild.parent.value).toBe(6)
	it "should add 13 as 14's left child", ->
		bst2.add(13)
		expect(bst2.root.rightChild.rightChild.leftChild.value).toBe(13)
		expect(bst2.root.rightChild.rightChild.leftChild.parent.value).toBe(14)
	it "should add 7 as 6's right child", ->
		bst2.add(7)
		expect(bst2.root.leftChild.rightChild.rightChild.value).toBe(7)
		expect(bst2.root.leftChild.rightChild.rightChild.parent.value).toBe(6)
	it "should add 1 as 3's left child", ->
		bst2.add(1)
		expect(bst2.root.leftChild.leftChild.value).toBe(1)
		expect(bst2.root.leftChild.leftChild.parent.value).toBe(3)
	it "shouldn't accept duplicates", ->
		bst2.add(1)
		bst2.add(7)
		bst2.add(6)
		bst2.add(14)
		bst2.add(3)
		bst2.add(13)
		bst2.add(8)
		bst2.add(4)
		bst2.add(10)
		expect(bst2.root.value).toBe(8)
		expect(bst2.root.leftChild.value).toBe(3)
		expect(bst2.root.leftChild.parent.value).toBe(8)
		expect(bst2.root.leftChild.leftChild.value).toBe(1)
		expect(bst2.root.leftChild.leftChild.parent.value).toBe(3)
		expect(bst2.root.leftChild.leftChild.leftChild).toBeUndefined()
		expect(bst2.root.leftChild.leftChild.rightChild).toBeUndefined()
		expect(bst2.root.leftChild.rightChild.value).toBe(6)
		expect(bst2.root.leftChild.rightChild.parent.value).toBe(3)
		expect(bst2.root.leftChild.rightChild.leftChild.value).toBe(4)
		expect(bst2.root.leftChild.rightChild.leftChild.parent.value).toBe(6)
		expect(bst2.root.leftChild.rightChild.leftChild.leftChild).toBeUndefined()
		expect(bst2.root.leftChild.rightChild.leftChild.rightChild).toBeUndefined()
		expect(bst2.root.leftChild.rightChild.rightChild.value).toBe(7)
		expect(bst2.root.leftChild.rightChild.rightChild.parent.value).toBe(6)
		expect(bst2.root.leftChild.rightChild.rightChild.leftChild).toBeUndefined()
		expect(bst2.root.leftChild.rightChild.rightChild.rightChild).toBeUndefined()
		expect(bst2.root.rightChild.value).toBe(10)
		expect(bst2.root.rightChild.parent.value).toBe(8)
		expect(bst2.root.rightChild.leftChild).toBeUndefined()
		expect(bst2.root.rightChild.rightChild.value).toBe(14)
		expect(bst2.root.rightChild.rightChild.parent.value).toBe(10)
		expect(bst2.root.rightChild.rightChild.leftChild.value).toBe(13)
		expect(bst2.root.rightChild.rightChild.leftChild.parent.value).toBe(14)
		expect(bst2.root.rightChild.rightChild.leftChild.leftChild).toBeUndefined()
		expect(bst2.root.rightChild.rightChild.leftChild.rightChild).toBeUndefined()
		expect(bst2.root.rightChild.rightChild.rightChild).toBeUndefined()

describe "Find", ->
	bst = new BST()
	it "should return nothing in an empty tree", ->
		expect(bst.find(1)).toBeUndefined()
		expect(bst.find(undefined)).toBeUndefined()
	it "should return a node if it's found", ->
		fillBalancedTree(bst)
		node10 = bst.find(10)
		node1 = bst.find(1)
		node7 = bst.find(7)
		node3 = bst.find(3)
		node14 = bst.find(14)
		node6 = bst.find(6)
		node8 = bst.find(8)
		node4 = bst.find(4)
		node13 = bst.find(13)
		expect(node8).toBeDefined()
		expect(node3).toBeDefined()
		expect(node10).toBeDefined()
		expect(node1).toBeDefined()
		expect(node6).toBeDefined()
		expect(node14).toBeDefined()
		expect(node4).toBeDefined()
		expect(node7).toBeDefined()
		expect(node13).toBeDefined()
		expect(node8.parent).toBeUndefined()
		expect(node3.parent.value).toBe(8)
		expect(node10.parent.value).toBe(8)
		expect(node1.parent.value).toBe(3)
		expect(node6.parent.value).toBe(3)
		expect(node14.parent.value).toBe(10)
		expect(node4.parent.value).toBe(6)
		expect(node7.parent.value).toBe(6)
		expect(node13.parent.value).toBe(14)
	it "should find undefined if it's a node", ->
		bst.add(undefined)
		expect(bst.find(undefined)).toBeDefined()
		expect(bst.find(undefined).parent.value).toBeDefined()
		expect(bst.find(undefined).value).toBeUndefined()

describe "Peek minimum", ->
	bst = new BST()
	it "should return undefined if the tree's empty", ->
		expect(bst.peekMinimum()).toBeUndefined()
	it "should return the minimum but does not remove it", ->
		fillBalancedTree(bst)
		expect(bst.peekMinimum()).toBe(1)
		expect(bst.peekMinimum()).toBe(1)

describe "Peek maximum", ->
	bst = new BST()
	it "should return undefined if the tree's empty", ->
		expect(bst.peekMaximum()).toBeUndefined()
	it "should return the maximum but does not remove it", ->
		fillBalancedTree(bst)
		expect(bst.peekMaximum()).toBe(14)
		expect(bst.peekMaximum()).toBe(14)

describe "Remove", ->
	bst = new BST()
	it "should return undefined for deleting in an empty tree", ->
		expect(bst.remove("hello")).toBeUndefined()
		expect(bst.remove(undefined)).toBeUndefined()
	it "should return undefined for deleting a non-existent value", ->
		fillBalancedTree(bst)
		expect(bst.remove("hello")).toBeUndefined()
		expect(bst.remove(undefined)).toBeUndefined()
		expect(bst.remove(-1)).toBeUndefined()
	it "should remove undefined if it's found", ->
		bst.add(undefined)
		# Find already checks that undefined is inserted correctly.
		bst.remove(undefined)
		expect(bst.find(undefined)).toBeUndefined()
	it "should return the removed value", ->
		expect(bst.remove(8)).toBe(8)
		expect(bst.remove(3)).toBe(3)
		expect(bst.remove(10)).toBe(10)
		expect(bst.remove(1)).toBe(1)
	it "should have removed correctly", ->
		expect(bst.find(8)).toBeUndefined()
		expect(bst.find(3)).toBeUndefined()
		expect(bst.find(10)).toBeUndefined()
		expect(bst.find(1)).toBeUndefined()
	it "should have kept the tree valid", ->
		node6 = bst.find(6)
		node14 = bst.find(14)
		node4 = bst.find(4)
		node7 = bst.find(7)
		node13 = bst.find(13)
		expect(bst.root).toEqual(node13)
		expect(node13.leftChild).toEqual(node4)
		expect(node13.rightChild).toEqual(node14)
		expect(node4.leftChild).toBeUndefined()
		expect(node13.leftChild).toEqual(node4)
		expect(node4.rightChild).toEqual(node6)
		expect(node6.leftChild).toBeUndefined()
		expect(node6.rightChild).toEqual(node7)
		expect(node7.leftChild).toBeUndefined()
		expect(node7.rightChild).toBeUndefined()
		expect(node14.leftChild).toBeUndefined()
		expect(node14.rightChild).toBeUndefined()
	it "should have an undefined root after removing everything", ->
		bst.remove(14)
		bst.remove(6)
		bst.remove(4)
		bst.remove(7)
		bst.remove(13)
		expect(bst.root).toBeUndefined()

describe "Remove minimum", ->
	bst = new BST()
	it "returns undefined when tree's empty", ->
		expect(bst.removeMinimum()).toBeUndefined()
	it "returns the smallest value", ->
		fillBalancedTree(bst)
		expect(bst.removeMinimum()).toBe(1)
		expect(bst.removeMinimum()).toBe(3)
		expect(bst.removeMinimum()).toBe(4)
		expect(bst.removeMinimum()).toBe(6)
		expect(bst.removeMinimum()).toBe(7)
		expect(bst.removeMinimum()).toBe(8)
		expect(bst.removeMinimum()).toBe(10)
		expect(bst.removeMinimum()).toBe(13)
		expect(bst.removeMinimum()).toBe(14)
	it "should return undefined for a newly emptied tree", ->
		expect(bst.removeMinimum()).toBeUndefined()

describe "Remove maximum", ->
	bst = new BST()
	it "returns undefined when tree's empty", ->
		expect(bst.removeMinimum()).toBeUndefined()
	it "returns the smallest value", ->
		fillBalancedTree(bst)
		expect(bst.removeMaximum()).toBe(14)
		expect(bst.removeMaximum()).toBe(13)
		expect(bst.removeMaximum()).toBe(10)
		expect(bst.removeMaximum()).toBe(8)
		expect(bst.removeMaximum()).toBe(7)
		expect(bst.removeMaximum()).toBe(6)
		expect(bst.removeMaximum()).toBe(4)
		expect(bst.removeMaximum()).toBe(3)
		expect(bst.removeMaximum()).toBe(1)
	it "should return undefined for a newly emptied tree", ->
		expect(bst.removeMinimum()).toBeUndefined()

