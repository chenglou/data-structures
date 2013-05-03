###
The initial idea was to use a `Node` class to store prev/next/node value.
But this requires additional space and is kind of heavy.

An array "node" consisting of `[prevReference, value, nextReference]` would be
fast and light, but would degrade the readability. Wrapper methods like
`next(arrayAsNode)` or `nextOf(arrayAsNode)` don't work well in chaining for the
public api. Adding prototype methods to Array as to enable `arrayAsNode.next()`
is dirty and comes back to the alternative of using objects.

The best option is to use {prev, value, next} object.

Then there's the question of whether using accesor methods or properties, i.e.
`list.head().next().value()` vs. `list.head.next.value`. The former
pyschologically prevents the direct modification of `next` which breaks the
traversal and is implementaion-independent. The latter is lighter and feels more
chainable. We'll use the latter for now.
###
class LinkedList
    constructor: (valuesToAdd = []) ->
        @head =
            prev: undefined
            value: undefined
            next: undefined
        @tail =
            prev: undefined
            value: undefined
            next: undefined
        # We keep track of the length for operations such as detecting empty
        # linked list and determining whether to start at the head or the tail
        # when getting a node.
        @_length = 0
        @add value for value in valuesToAdd

    ###
    There will be a point where we need to retrieve a node at a certain
    position. It'll double as a helper method and a public one. Position allows
    negative index for python style quick access to last items. Position smaller
    than -length or bigger than length is discarded, as they're more likely done
    by mistakes.
    ###
    _adjust: (position) ->
        if position < 0 then @_length + position
        else position

    get: (position) ->
        if not (-@_length <= position < @_length) then return

        position = @_adjust position
        # Starting from the head or tail will require a different loop count.
        # How many times to loop in each case?
        if position * 2 < @_length
            currentNode = @head
            currentNode = currentNode.next for i in [1..position] by 1
        else
            currentNode = @tail
            currentNode = currentNode.prev for i in [1..@_length - position - 1] by 1
        return currentNode

    # There's a trade-off between conciseness and developer comfort when
    # choosing between an add and remove that do all, and array-like methods
    # such as pop and shift. We choose the former. Wrapper methods are a
    # possibility.
    add: (value, position = @_length) ->
        if not (-@_length <= position <= @_length) then return
        # Position specifies the place the value's going to be, and the old node
        # will be pushed higher. `add(-2)` on length of 7 is the same as
        # `add(5)`.
        nodeToAdd = {value: value}
        position = @_adjust position
        if @_length is 0
            @head = nodeToAdd
        else
            if position is 0
                [@head.prev, nodeToAdd.next, @head] = [nodeToAdd, @head, nodeToAdd]
            else
                # Get the node before the position we're inserting. Its next
                # needs to be changed.
                currentNode = @get(position - 1)
                # Now the linking part. We cannot use CoffeeScript's quick
                # assignment using `[]`. The references get mingled.
                nodeToAdd.next = currentNode.next
                currentNode.next?.prev = nodeToAdd
                currentNode.next = nodeToAdd
                nodeToAdd.prev = currentNode
        # Join the tail too. Modify tail when the node was inserted at the last
        # position.
        if position is @_length then @tail = nodeToAdd
        @_length++
        return value

    # Remove requires different position limits than add.
    remove: (position = @_length - 1) ->
        if not (-@_length <= position < @_length) then return
        if @_length is 0 then return

        position = @_adjust position
        if @_length is 1
            valueToReturn = @head.value
            @head.value = @tail.value = undefined
        else
            if position is 0
                valueToReturn = @head.value
                @head = @head.next
                @head.prev = undefined
            else
                currentNode = @get(position)
                valueToReturn = currentNode.value
                currentNode.prev.next = currentNode.next
                currentNode.next?.prev = currentNode.prev
                # Notice how this conditional's placement differs from add. Tail
                # is taken care of in this case.
                if position is @_length - 1 then @tail = currentNode.prev
        @_length--
        return valueToReturn

    # The indexOf method only traverse forwardly. We need to be careful about
    # finding undefined and null values. The starting position accepts nagetive
    # indexing. A negative index whose absolute value is smaller than the length
    # is treated as 0.
    indexOf: (value, startingPosition = 0) ->
        if (not @head.value? and not @head.next) or startingPosition >= @_length
            return -1
        startingPosition = Math.max(0, @_adjust startingPosition)
        currentNode = @get startingPosition
        position = startingPosition
        while currentNode
            if currentNode.value is value then break
            currentNode = currentNode.next
            position++
        return if position is @_length then -1 else position

module.exports = LinkedList
