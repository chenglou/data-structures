# Data Structures [![Build Status](https://travis-ci.org/chenglou/data-structures.png?branch=master)](https://travis-ci.org/chenglou/data-structures)
Fast, light and hassle-free JavaScript data structures, written in CoffeeScript.

- (Hash) Map
- Heap
- Graph
- (Doubly) Linked List
- Queue
- Self-Balancing Binary Search Tree (Red-Black Tree)
- Trie

## [Roadmap](https://github.com/chenglou/data-structures/wiki/Roadmap)

## Installation
Using [npm](http://www.npmjs.org):
```bash
npm install data-structures
```

## Usage
```coffee
Heap = require('data-structures').Heap
heap = new Heap()
heap.add(3)
```

JavaScript version and browser support coming soon.

## Documentation
[Wiki page](https://github.com/chenglou/data-structures/wiki)

The wiki page is a formatted version of the documentation in the code.

## For Contributors
Tests are done using [jasmine-node](https://github.com/mhevery/jasmine-node).

E.g.:
```bash
jasmine-node --coffee tests/LinkedList.spec.coffee
```

Lazy method:
```bash
npm test
```

## License
MIT.
