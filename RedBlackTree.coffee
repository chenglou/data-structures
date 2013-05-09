# TODO: consider if remove and peek should return empty node instead of
# undefined. Also check if undefined and null work well with rotations.

NODE_FOUND = 0
NODE_TOO_BIG = 1
NODE_TOO_SMALL = 2
STOP_SEARCHING = 3
RED = "RED"
BLACK = "BLACK"


###
Credit to Wikipedia's article on [Red-black
tree](http://en.wikipedia.org/wiki/Red–black_tree)

**Note:** doesn't handle duplicate entries. This is by design.
###

# Property of a red-black tree, taken from Wikipedia:

# 1. A node is either red or black.
# 2. Root is black.
# 3. Leaves are all null and considered black.
# 4. Both children of a red node are black.
# 5. Every path from a node to any of its descendent leaves contains the same
# number of black nodes.

# In our implementation, leaves are simply undefined.
class RedBlackTree
    constructor: (valuesToAdd = []) ->
        ###
        Pass an optional array to be turned into binary tree.
        ###
        @root
        @add value for value in valuesToAdd

    add: (value) ->
        ###
        Again, make sure to not pass a value already in the tree.

        _Returns:_ value added.
        ###
        nodeToInsert =
            value: value
            color: RED

        if not @root then @root = nodeToInsert
        else
            foundNode = _findNode @root, (node) ->
                if value is node.value then NODE_FOUND
                else
                    if value < node.value
                        if node.leftChild then NODE_TOO_BIG
                        else
                            nodeToInsert.parent = node
                            node.leftChild = nodeToInsert
                            STOP_SEARCHING
                    # Inserting "undefined" will go to right child. Important to
                    # keep this conditional in sync with has().
                    else
                        if node.rightChild then NODE_TOO_SMALL
                        else
                            nodeToInsert.parent = node
                            node.rightChild = nodeToInsert
                            STOP_SEARCHING
            if foundNode? then return
        # After adding the node, we need to operate on it to preserve the tree's
        # properties by filtering it through a series of cases. It'd be easier
        # if there's tail recursion in JavaScript, as some cases fix the node
        # but restart the cases on the node's ancestor. We'll have to use loops
        # for now.
        currentNode = nodeToInsert
        loop
            # Case 1: node is root. Violates 1. Paint it black.
            if currentNode is @root
                currentNode.color = BLACK
                break
            # Case 2: parent black. No properties violated. After that, parent
            # is sure to be red.
            if currentNode.parent.color is BLACK
                break
            # Case 3: if node's parent and uncle are red, they are painted
            # black. Their parent (node's grandparent) should be painted red,
            # and the grandparent red. Note that node certainly has a
            # grandparent, since at this point, its parent's red, which can't be
            # the root.

            # After the painting, the grandparent might violate 2 or 4.
            if _uncleOf(currentNode)?.color is RED
                currentNode.parent.color = BLACK
                _uncleOf(currentNode).color = BLACK
                _grandParentOf(currentNode).color = RED
                currentNode = _grandParentOf currentNode
                continue
            # At this point, uncle is either black or doesn't exist.

            # Case 4: parent red, uncle black, node is right child, parent is
            # left child. Do a left rotation. Then, former parent passes through
            # case 5.
            if not _isLeftChild(currentNode) and _isLeftChild(currentNode.parent)
                @_rotateLeft currentNode.parent
                currentNode = currentNode.leftChild
            else if _isLeftChild(currentNode) and not _isLeftChild(currentNode.parent)
                @_rotateRight currentNode.parent
                currentNode = currentNode.rightChild
            # Case 5: parent red, uncle black, node is left child, parent is
            # left child. Right rotation. Switch parent and grandparent's color.
            currentNode.parent.color = BLACK
            _grandParentOf(currentNode).color = RED
            if _isLeftChild currentNode
                @_rotateRight _grandParentOf currentNode
            else
                @_rotateLeft _grandParentOf currentNode
            break
        return value

    has: (value) ->
        ###
        _Returns:_ true or false.
        ###
        foundNode = _findNode @root, (node) ->
            if value is node.value then NODE_FOUND
            # Keep the conditional this way; node.value > value wouldn't work.
            # The insertion uses the same comparison to add "undefined" (to the
            # right child).
            else if value < node.value then NODE_TOO_BIG
            else NODE_TOO_SMALL
        if foundNode then yes else no

    peekMin: ->
        ###
        Check the minimum value without removing it.

        _Returns:_ the minimum value.
        ###
        _peekMinNode(@root)?.value

    peekMax: ->
        ###
        Check the maximum value without removing it.

        _Returns:_ the maximum value.
        ###
        _peekMaxNode(@root)?.value

    remove: (value) ->
        ###
        _Returns:_ the value removed, or undefined if the value's not found.
        ###
        foundNode = _findNode @root, (node) ->
            if value is node.value then NODE_FOUND
            # Keep the conditional this way; node.value > value wouldn't work.
            # The insertion uses the same comparison to add "undefined" (to the
            # right child).
            else if value < node.value then NODE_TOO_BIG
            else NODE_TOO_SMALL
        if not foundNode then return
        @_removeNode @root, foundNode
        return value

    removeMin: ->
        ###
        _Returns:_ smallest item removed, or undefined if tree's empty.
        ###
        nodeToRemove = _peekMinNode @root
        if not nodeToRemove then return
        # Store in. Might destroy the node during removal in the future, so
        # can't just return nodeToRemove.value.
        valueToReturn = nodeToRemove.value
        @_removeNode @root, nodeToRemove
        return valueToReturn

    removeMax: ->
        ###
        _Returns:_ biggest item removed, or undefined if tree's empty.
        ###
        nodeToRemove = _peekMaxNode @root
        if not nodeToRemove then return
        # Store in. Might destroy the node during removal in the future, so
        # can't just return nodeToRemove.value.
        valueToReturn = nodeToRemove.value
        @_removeNode @root, nodeToRemove
        return valueToReturn


    # To simplify removal cases, we can notice this:

    # 1. Node has no child.

    # 2. Node has two children. Select the smallest child on the right branch
    # (leftmost) and copy its value into the node to delete. This replacement
    # node certainly has less than two children or it wouldn't be the smallest.
    # Then delete this replacement node.

    # 3. Node has one child.

    # They all come down to removing a node with maximum one child.
    _removeNode: (root, node) ->
        if node.leftChild and node.rightChild
            successor = _peekMinNode node.rightChild
            node.value = successor.value
            node = successor
        # At this point, the node to remove has only one child.
        successor = node.leftChild or node.rightChild
        if not successor
            # Hard code a leaf in, to make case checking easier.
            successor =
                color: BLACK
                rightChild: undefined
                leftChild: undefined
                isLeaf: yes

        successor.parent = node.parent
        node.parent?[_leftOrRightChild node] = successor
        # We're done if node's red. If it's black and its child that took its
        # place is red, change it to black. If both are black, we do cases
        # checking like in insert.
        if node.color is BLACK
            if successor.color is RED
                successor.color = BLACK
                if not successor.parent then @root = successor
            else
                loop
                    # Case 1: node is root. Done.
                    if not successor.parent
                        if not successor.isLeaf then @root = successor
                        else @root = undefined
                        break
                    # Case 2: sibling red. Flip color of P and S. Left rotate P.
                    sibling = _siblingOf successor
                    if sibling?.color is RED
                        successor.parent.color = RED
                        sibling.color = BLACK
                        if _isLeftChild successor
                            @_rotateLeft successor.parent
                        else @_rotateRight successor.parent
                    # Case 3: parent, sibling and sibling children all black.
                    # Paint sibling red. Rebalance parent.
                    sibling = _siblingOf successor
                    if successor.parent.color is BLACK and
                        (not sibling or (sibling.color is BLACK and
                        (not sibling.leftChild or sibling.leftChild.color is BLACK) and
                        (not sibling.rightChild or sibling.rightChild.color is BLACK)))
                            sibling?.color = RED
                            if successor.isLeaf then successor.parent[_leftOrRightChild successor] = undefined
                            successor = successor.parent
                            continue
                    # Case 4: sibling and sibling children black. Node parent
                    # red. Swap color of sibling and node parent.
                    if successor.parent.color is RED and
                    (not sibling or (sibling.color is BLACK and
                    (not sibling.leftChild or sibling.leftChild?.color is BLACK) and
                    (not sibling.rightChild or sibling.rightChild?.color is BLACK)))
                        sibling?.color = RED
                        successor.parent.color = BLACK
                        break
                    # Case 5: sibling black, sibling left child red, right child
                    # black, node is left child. Rotate right sibling. Swap
                    # color of sibling and its new parent.
                    if sibling?.color is BLACK
                        if _isLeftChild(successor) and
                        (not sibling.rightChild or sibling.rightChild.color is BLACK) and
                        sibling.leftChild?.color is RED
                            sibling.color = RED
                            sibling.leftChild?.color = BLACK
                            @_rotateRight sibling
                        else if not _isLeftChild(successor) and
                        (not sibling.leftChild or sibling.leftChild.color is BLACK) and
                        sibling.rightChild?.color is RED
                            sibling.color = RED
                            sibling.rightChild?.color = BLACK
                            @_rotateLeft sibling
                        break
                    # Case 6: sibling black, sibling right child red, node is
                    # left child. Rotate left node parent. Swap color of parent
                    # and sibling. Paint sibling right child black.
                    sibling = _siblingOf successor
                    sibling.color = successor.parent.color
                    if _isLeftChild successor
                        sibling.rightChild.color = BLACK
                        @_rotateRight successor.parent
                    else
                        sibling.leftChild.color = BLACK
                        @_rotateLeft successor.parent
        # Don't forget to detatch the artificially created leaf.
        if successor.isLeaf
            successor.parent?[_leftOrRightChild successor] = undefined

    _rotateLeft: (node) ->
        node.parent?[_leftOrRightChild node] = node.rightChild
        node.rightChild.parent = node.parent
        node.parent = node.rightChild
        node.rightChild = node.rightChild.leftChild
        node.parent.leftChild = node
        node.rightChild?.parent = node
        if not node.parent.parent? then @root = node.parent

    _rotateRight: (node) ->
        node.parent?[_leftOrRightChild node] = node.leftChild
        node.leftChild.parent = node.parent
        node.parent = node.leftChild
        node.leftChild = node.leftChild.rightChild
        node.parent.rightChild = node
        node.leftChild?.parent = node
        if not node.parent.parent? then @root = node.parent

_isLeftChild = (node) -> node is node.parent.leftChild
_leftOrRightChild = (node) ->
    # No need to check if parent exist. It's never used this way.
    if _isLeftChild node then "leftChild" else "rightChild"

_findNode = (startingNode, comparator) ->
    currentNode = startingNode
    foundNode = undefined
    while currentNode
        comparisonResult = comparator currentNode
        if comparisonResult is NODE_FOUND
            foundNode = currentNode
            break
        if comparisonResult is NODE_TOO_BIG
            currentNode = currentNode.leftChild
        else if comparisonResult is NODE_TOO_SMALL
            currentNode = currentNode.rightChild
        else if comparisonResult is STOP_SEARCHING
            break
    return foundNode

_peekMinNode = (startingNode) ->
    _findNode startingNode, (node) ->
        if node.leftChild then NODE_TOO_BIG else NODE_FOUND

_peekMaxNode = (startingNode) ->
    _findNode startingNode, (node) ->
        if node.rightChild then NODE_TOO_SMALL else NODE_FOUND

_grandParentOf = (node) -> node.parent?.parent

_uncleOf = (node) ->
    if not _grandParentOf node then return
    if _isLeftChild node.parent
        _grandParentOf(node).rightChild
    else
        _grandParentOf(node).leftChild

_siblingOf = (node) ->
    if _isLeftChild node then node.parent.rightChild
    else node.parent.leftChild

module.exports = RedBlackTree

