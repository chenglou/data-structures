###
Array under the hood. The slow operation is `array.shift()` at O(n). So instead
of simply removing the head, mark it as "garbage collectable" by moving up the
dequeue index up (i.e. "dequeue this element next time").

When half of array is garbage collectable, slice these items.
###
class Queue
    constructor: (initialArray = []) ->
        @_content = initialArray
        @_dequeueIndex = 0
        @length = @_content.length

    enqueue: (item) ->
        @length++
        @_content.push(item)
        return item

    dequeue: ->
        if @length is 0 then return
        @length--
        itemToDequeue = @_content[@_dequeueIndex]
        @_dequeueIndex++
        if @_dequeueIndex * 2 > @_content.length
            @_content = @_content.slice(@_dequeueIndex)
            @_dequeueIndex = 0
        return itemToDequeue

    peek: -> @_content[@_dequeueIndex]

module.exports = Queue
