Queue1 = require './Queue'
Queue2 = require './Queue2'
Queue3 = require './LinkedList'
queue1 = new Queue1()
queue2 = new Queue2()
queue3 = new Queue3()

start = new Date()
for i in [0..9999999]
    queue3.add Math.random()
    queue3.remove(0)
end = new Date()
console.log end - start

start = new Date()
for i in [0..9999999]
    1
end = new Date()
console.log end - start
