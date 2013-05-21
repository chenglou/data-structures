# Data Structures [![Build Status](https://travis-ci.org/chenglou/data-structures.png?branch=master)](https://travis-ci.org/chenglou/data-structures)
Fast, light and hassle-free JavaScript data structures, written in CoffeeScript.

- (Hash) Map
- Heap
- Graph
- (Doubly) Linked List
- Queue
- Self-Balancing Binary Search Tree (Red-Black Tree)
- Trie

## Installation and Usage

### Server-side:
Using [npm](http://www.npmjs.org):
```bash
npm install data-structures
```
Then where needed:
```js
var Heap = require('data-structures').Heap;
var heap = new Heap();
heap.add(3);
heap.removeMin();
```
Alternatively, you can directly use the compiled JavaScript version in the "distribution" folder. It's always in sync with the CoffeeScript one.

### Client-side:
[Get the whole file here.](https://github.com/chenglou/data-structures/tree/master/distribution)
Either use the development version or the minified production version.

Then put the file in your HTML page,
```html
<script src="./data-structures-versionHere.min.js"></script>
<script>
    var Heap = require("data-structures").Heap;
    var heap = new Heap();
    heap.add(3);
    heap.removeMin();
</script>
```
(Magical client-side `require()`) courtesy of [Browserify](https://github.com/substack/node-browserify).

## Documentation
[Wiki page](https://github.com/chenglou/data-structures/wiki)

The wiki page is a formatted version of the documentation in the code.

## [Roadmap](https://github.com/chenglou/data-structures/wiki/Roadmap)

## For Contributors
First, install the npm development dependencies:
```bash
npm install
```

### Testing
Tests are done using [jasmine-node](https://github.com/mhevery/jasmine-node).

Testing individual file, e.g.:
```bash
jasmine-node --coffee tests/LinkedList.spec.coffee
```

Lazy method:
```bash
npm test
```

### Export for browser
You'll need the [grunt-cli tool](http://gruntjs.com/getting-started):
```bash
npm install -g grunt-cli
```
Then run:
```bash
grunt
```

## License
MIT.
