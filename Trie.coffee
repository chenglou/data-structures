# Needed for breath-first traversal for finding all words with a certain prefix.
Queue = require './Queue'
# Special value for marking end of word. No conflict possible, since every
# node's one letter.
WORD_END = "end"
class Trie
	constructor: (words = []) ->
		@_root = {}
		for word in words
			@add word

	add: (word) ->
		if not word? then return word
		currentNode = @_root
		for letter in word
			if not currentNode[letter]? then currentNode[letter] = {}
			currentNode = currentNode[letter]
		# Add the terminator. The value should be something defined, as to not
		# cause search problems and so that we can validate using `if
		# currentNode[WORD_END]` rather than `if currentNode[WORD_END]?`
		currentNode[WORD_END] = yes
		return word

	hasWord: (word) ->
		if not word? then return no
		currentNode = @_root
		for letter in word
			if not currentNode[letter]? then return no
			currentNode = currentNode[letter]
		# Check for null terminator
		if currentNode[WORD_END] then yes
		else no

	longestPrefixOf: (word) ->
		if not word? then return ""
		currentNode = @_root
		prefix = ""
		for letter in word
			if not currentNode[letter]? then break
			prefix += letter
			currentNode = currentNode[letter]
		return prefix

	wordsWithPrefix: (prefix) ->
		if not prefix? then return []
		# Cannot put default value to parameter. It'll transform undefined and null into "".
		prefix? or prefix = ""
		words = []
		currentNode = @_root
		for letter in prefix
			currentNode = currentNode[letter]
			if not currentNode? then return []
		# Reached the end of prefix.
		# Enqueue like this: [node, accumulatedLetters]
		queue = new Queue()
		queue.enqueue [currentNode, ""]
		while queue.length isnt 0
			[node, accumulatedLetters] = queue.dequeue()
			# console.log "yo", node
			if node[WORD_END]
				words.push prefix + accumulatedLetters
			for letter, subNode of node
				queue.enqueue [subNode, accumulatedLetters + letter]
		return words

module.exports = Trie
