###
General library conventions:

- Properties and methods with a leading underscore are private. None is exposed
publicly, but sometimes you might inevitably find them while retrieving objects.
They shouldn't be modified.

- Most insertion, deletion and fetch methods are called `add something`, `remove
something` and `get something`, where it makes sense. These methods also return
the item added/removed/gotten, unless stated otherwise.

- The property/method names are all chosen for their readability, expressiveness
and consistency across the library. Most of the times you can guess them.

Happy coding! Feel free to drop your suggestions on the issues page, thank you!
###
module.exports =
    Graph: require './Graph'
    Heap: require './Heap'
    Linkedlist: require './LinkedList'
    Map: require './Map'
    Queue: require './Queue'
    RedBlackTree: require './RedBlackTree'
    Trie: require './Trie'
