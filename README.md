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

### Client-side:
Get the whole file here: [data-structures.js](https://raw.github.com/chenglou/data-structures/master/distribution/data-structures.js) or minified: [data-structures.min.js](https://raw.github.com/chenglou/data-structures/master/distribution/data-structures.min.js)

Then put the file in your HTML page, **note that the code is `require`d differently:**
```html
<script src="./data-structures.min.js"></script>
<script>
    var heap = require("./Heap");
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

### Testing
Tests are done using [jasmine-node](https://github.com/mhevery/jasmine-node).

E.g.:
```bash
jasmine-node --coffee tests/LinkedList.spec.coffee
```

Lazy method:
```bash
npm test
```

### Export for browser
```bash
npm run-script browserExport
```
(Compiles CoffeeScript to JavaScript, [browserifies](https://github.com/substack/node-browserify) them into a bundle, then minifies using [uglify-js](https://github.com/mishoo/UglifyJS2)).

## License
MIT.
