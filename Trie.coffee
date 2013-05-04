# Needed for breath-first traversal for finding all words with a certain prefix.
Queue = require './Queue'
# Special value for marking end of word. No conflict possible, since every
# node's one letter.
WORD_END = "end"
class Trie
    constructor: (words = []) ->
        ###
        Pass an optional array of strings to be made into the trie.
        ###
        @_root = {}
        @add word for word in words

    add: (word) ->
        ###
        Add a whole string to the trie.

        _Returns:_ the word added. Will return undefined (without adding the
        value) if the word passed is null or undefined.
        ###
        if not word? then return undefined
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
        ###
        __Returns:_ true or false.
        ###
        if not word? then return no
        currentNode = @_root
        for letter in word
            if not currentNode[letter]? then return no
            currentNode = currentNode[letter]
        # Check for null terminator
        if currentNode[WORD_END] then yes
        else no

    longestPrefixOf: (word) ->
        ###
        Find all words containing the prefix. The word itself counts as a
        prefix.
        ```coffee
        trie = new Trie()
        trie.add("hello")
        trie.longestPrefixOf("he") # "he"
        trie.longestPrefixOf("hello") # "hello"
        trie.longestPrefixOf("helloha!") # "hello"
        ```

        _Returns:_ the prefix string, or empty string if no prefix found.
        ###
        if not word? then return ""
        currentNode = @_root
        prefix = ""
        for letter in word
            if not currentNode[letter]? then break
            prefix += letter
            currentNode = currentNode[letter]
        return prefix

    wordsWithPrefix: (prefix) ->
        ###
        Find all words containing the prefix. The word itself counts as a
        prefix. **Watch out for edge cases.**
        ```coffee
        trie = new Trie()
        trie.wordsWithPrefix("") # []. Check later case below.
        trie.add("")
        trie.wordsWithPrefix("") # [""]
        trie.add "he"
        trie.add "hello"
        trie.add "hell"
        trie.add "bear"
        trie.add "z"
        trie.add "zebra"
        trie.wordsWithPrefix("hel") # ["hell", "hello"]

        _Returns:_ an array of strings, or empty array if no word found.
        ```
        ###
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
            if node[WORD_END]
                words.push prefix + accumulatedLetters
            for letter, subNode of node
                queue.enqueue [subNode, accumulatedLetters + letter]
        return words

module.exports = Trie
