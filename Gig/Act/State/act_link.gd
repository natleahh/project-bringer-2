class_name ActLink extends Object

signal unlinked
signal updated

## Connection Depenant State
var _connection_state: ActState
var _state_fields: ActState.LinkFields:
	get: return _connection_state.links[self]

var active: bool:
	get: return _state_fields.active
var connectors: Array[ActConnector]:
	get: return [left, right]
var left: ActConnector:
	get: return _state_fields.left
var right: ActConnector:
	get: return _state_fields.right

func _init(act: ActState) -> void:
	_connection_state = act
