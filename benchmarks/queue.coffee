# NOTE: innacurate benchmark. Number of operations should be a constant.

Benchmark = require 'benchmark'
Queue1 = require '../Queue'
Queue2 = require '../Queue2'
Queue3 = require '../LinkedList2'

queue1 = new Queue1()
queue2 = new Queue2()
queue3 = new Queue3()

suite = new Benchmark.Suite
suite.add 'Queue1 enqueue', () -> queue1.enqueue Math.random()
suite.add 'Queue2 enqueue', () -> queue2.enqueue Math.random()
suite.add 'Queue3 enqueue', () -> queue3.add Math.random()

suite.on 'cycle', (event) -> console.log String(event.target)

suite.on 'complete', () ->
  console.log('Fastest is ' + this.filter('fastest').pluck('name'))

suite.run()

suite2 = new Benchmark.Suite
suite2.add 'Queue1 dequeue', () -> queue1.dequeue()
suite2.add 'Queue2 dequeue', () -> queue2.dequeue()
suite2.add 'Queue3 dequeue', () -> queue3.remove 0

suite2.on 'cycle', (event) -> console.log String(event.target)

suite2.on 'complete', () ->
  console.log('Fastest is ' + this.filter('fastest').pluck('name'))

suite2.run()

suite3 = new Benchmark.Suite
suite3.add 'Queue1 enqueue+dequeue', () ->
    queue1.enqueue Math.random()
    queue1.dequeue()

suite3.add 'Queue2 enqueue+dequeue', () ->
    queue2.enqueue Math.random()
    queue2.dequeue()

suite3.add 'Queue3 enqueue+dequeue', () ->
    queue3.add Math.random()
    queue3.remove 0

suite3.on 'cycle', (event) -> console.log String(event.target)

suite3.on 'complete', () ->
  console.log('Fastest is ' + this.filter('fastest').pluck('name'))

suite3.run()
