# TODO: maybe change the hashing method for arrays and objects to something less hacky.
# We can recursively dig out their properties' value and join them, but that'd make it O(n).

# For hashing special types, e.g. objects, arrays and dates.
SPECIAL_TYPE_KEY_PREFIX = '_mapId_'
class Map
	# Class variable and method.
	@_mapIdTracker: 0
	@_newMapId: ->
		@_mapIdTracker++
	
	constructor: ->
		@_content = {}
		# Used to track objects and arrays.
		@_itemId = 0
		@_id = Map._newMapId()

	# Public. Allow user-defined hash function.
	hash: (key, makeHash = no) ->
		# [object stringToKeep].
		type = Object.prototype.toString.apply(key).match(/\[object (.+)\]/)[1]
		# Obscure hack to add a secret property to the object, used as key for hash map.
		# Reason for doing so on array: [obj1, obj2] would have the same hash as [obj3, obj4]
		if _isSpecialType(key)
			propertyForMap = SPECIAL_TYPE_KEY_PREFIX + @_id
			if makeHash and not key[propertyForMap]
				key[propertyForMap] = @_itemId++
			# Format: '_hashMapId'
			return propertyForMap + '_' + key[propertyForMap]
		else
			return type + '_' + key

	set: (key, value) ->
		@_content[@hash(key, yes)] = value

	get: (key) ->
		@_content[@hash(key)]

	has: (key) ->
		@hash(key) of @_content

	delete: (key) ->
		hashedKey = @hash(key)
		if hashedKey of @_content
			delete @_content[hashedKey]
			if _isSpecialType(key) then delete key[SPECIAL_TYPE_KEY_PREFIX + @_id]
			return true
		return false

	forEach: (func) ->
		func(key, value) for key, value of @_content

_isSpecialType = (key) ->
	type = Object.prototype.toString.apply(key)
	type is '[object Object]' or type is '[object Array]' or type is '[object Date]'

module.exports = Map
