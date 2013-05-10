# Array under the hood. The slow operation is `array.shift()` at O(n). So
# instead of simply removing the head, mark it as "garbage collectable" by
# moving up the dequeue index up (i.e. "dequeue this element next time").

# When half of array is garbage collectable, slice these items.

class Queue
    ###
    Properties
    - length
    ###
    constructor: (initialArray = []) ->
        ###
        Pass an optional array to be transformed into a queue. The item at index
        0 is the first to be dequeued.
        ###
        @_content = initialArray
        @_dequeueIndex = 0
        @length = @_content.length

    enqueue: (item) ->
        ###
        _Returns:_ the item.
        ###
        @length++
        @_content.push(item)
        return item

    dequeue: ->
        ###
        _Returns:_ the dequeued item.
        ###
        if @length is 0 then return
        @length--
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

    isEmpty: ->
        ###
        _Returns:_ true or false.
        ###
        @length is 0


module.exports = Queue
