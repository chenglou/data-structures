# Array under the hood. The slow operation is `array.shift()` at O(n). So
# instead of simply removing the head, mark it as "garbage collectable" by
# moving up the dequeue index up (i.e. "dequeue this element next time").

# When half of array is garbage collectable, slice these items.

###
Properties:

- size: The total number of items.
###
class Queue
    constructor: (initialArray = []) ->
        ###
        Pass an optional array to be transformed into a queue. The item at index
        0 is the first to be dequeued.
        ###
        @_content = initialArray
        @_dequeueIndex = 0
        @size = @_content.length

    enqueue: (item) ->
        ###
        _Returns:_ the item.
        ###
        @size++
        @_content.push(item)
        return item

    dequeue: ->
        ###
        _Returns:_ the dequeued item.
        ###
        if @size is 0 then return
        @size--
        itemToDequeue = @_content[@_dequeueIndex]
        @_dequeueIndex++
        if @_dequeueIndex * 2 > @_content.length
            @_content = @_content.slice(@_dequeueIndex)
            @_dequeueIndex = 0
        return itemToDequeue

    peek: ->
        ###
        Check the next item to be dequeued, without removing it.

        _Returns:_ the item.
        ###
        @_content[@_dequeueIndex]

module.exports = Queue
