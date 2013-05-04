Trie = require '../Trie'

# Shorthand for logging.
l = (x) -> console.log require('util').inspect x, true, 10

fill = (trie) ->
    trie.add "he"
    trie.add "hello"
    trie.add "hell"
    trie.add "bear"
    trie.add "beer"
    trie.add "z"
    trie.add "za"
    trie.add "zz"

# Testing extensively for undefined/null/empty string/no parameter value here,
# because Trie uses null as word terminator.
describe "Add word and check for it", ->
    trie = new Trie()
    it "should return nothing when the trie's empty", ->
        expect(trie.hasWord "").toBeFalsy()
        expect(trie.hasWord "beer").toBeFalsy()
        expect(trie.hasWord()).toBeFalsy()
    it "should return the word added", ->
        expect(trie.add "he").toBe "he"
        expect(trie.add "hello").toBe "hello"
        expect(trie.add "hell").toBe "hell"
        expect(trie.add "beer").toBe "beer"
    it "should find the words just added, and nothing but", ->
        expect(trie.hasWord "hello").toBeTruthy()
        expect(trie.hasWord "hell").toBeTruthy()
        expect(trie.hasWord "he").toBeTruthy()
        expect(trie.hasWord "beer").toBeTruthy()
        expect(trie.hasWord "bee").toBeFalsy()
    it "should ignore adding null and undefined", ->
        expect(trie.hasWord null).toBeFalsy()
        expect(trie.hasWord()).toBeFalsy()
        expect(trie.hasWord undefined).toBeFalsy()
        expect(trie.add null).toBeUndefined()
        expect(trie.add()).toBeUndefined()
        expect(trie.add undefined).toBeUndefined()
        expect(trie.hasWord null).toBeFalsy()
        expect(trie.hasWord()).toBeFalsy()
        expect(trie.hasWord undefined).toBeFalsy()
    it "should add an empty string as a valid word", ->
        expect(trie.hasWord "").toBeFalsy()
        expect(trie.add "").toBe ""
        expect(trie.hasWord null).toBeFalsy()
        expect(trie.hasWord()).toBeFalsy()
        expect(trie.hasWord undefined).toBeFalsy()
        expect(trie.hasWord "").toBeTruthy()
    it "should not add the same word more than once", ->
        # Not sure how to test this.
        fill trie
        expect(trie.hasWord "").toBeTruthy()
        expect(trie.hasWord "he").toBeTruthy()
        expect(trie.hasWord "hello").toBeTruthy()
        expect(trie.hasWord "hell").toBeTruthy()
        expect(trie.hasWord "beer").toBeTruthy()
        expect(trie.hasWord "bear").toBeTruthy()
        expect(trie.hasWord "z").toBeTruthy()
        expect(trie.hasWord "za").toBeTruthy()
        expect(trie.hasWord "zz").toBeTruthy()

describe "Initialization with an array", ->
    trie = new Trie ["hello", "he", "hell", "beer", null, "apple", undefined]
    it "should have formed the trie correctly", ->
        expect(trie.hasWord "hello").toBeTruthy()
        expect(trie.hasWord "hell").toBeTruthy()
        expect(trie.hasWord "he").toBeTruthy()
        expect(trie.hasWord "beer").toBeTruthy()
        expect(trie.hasWord "apple").toBeTruthy()

describe "Find the longest prefix of a word", ->
    trie = new Trie()
    it "should return an empty string if the word's not found", ->
        expect(trie.longestPrefixOf()).toBe ""
        expect(trie.longestPrefixOf null).toBe ""
        expect(trie.longestPrefixOf undefined).toBe ""
        expect(trie.longestPrefixOf "").toBe ""
        expect(trie.longestPrefixOf "beer").toBe ""
    it "should return the correct prefix otherwise", ->
        fill trie
        expect(trie.longestPrefixOf "hel").toBe "hel"
        expect(trie.longestPrefixOf "helloha").toBe "hello"
        expect(trie.longestPrefixOf "h").toBe "h"
        expect(trie.longestPrefixOf "beers").toBe "beer"
        expect(trie.longestPrefixOf "").toBe ""
        expect(trie.longestPrefixOf "a").toBe ""
        expect(trie.longestPrefixOf null).toBe ""
        expect(trie.longestPrefixOf undefined).toBe ""
        expect(trie.longestPrefixOf()).toBe ""

describe "Find all words matching a prefix", ->
    trie = new Trie()
    it "should return an empty array if nothing's found", ->
        expect(trie.wordsWithPrefix "asd").toEqual []
        expect(trie.wordsWithPrefix undefined).toEqual []
        expect(trie.wordsWithPrefix null).toEqual []
        expect(trie.wordsWithPrefix()).toEqual []
        expect(trie.wordsWithPrefix "").toEqual []
    it "should return every word if an empty string is passed", ->
        fill trie
        expect(trie.wordsWithPrefix undefined).toEqual []
        expect(trie.wordsWithPrefix null).toEqual []
        expect(trie.wordsWithPrefix "").toEqual ["z", "he", "za", "zz", "hell", "bear", "beer", "hello"]
        expect(trie.wordsWithPrefix()).toEqual []
    it "should return the same array, plus the empty string, if it was added", ->
        trie.add ""
        expect(trie.wordsWithPrefix "").toEqual ["", "z", "he", "za", "zz", "hell", "bear", "beer", "hello"]
    it "should include the word itself", ->
        expect(trie.wordsWithPrefix "hell").toEqual ["hell", "hello"]

