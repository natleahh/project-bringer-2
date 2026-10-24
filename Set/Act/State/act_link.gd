class_name ActLink extends Object

## Connection State
var _connection_state: ActState
var connectors: Array[ActConnector]:
	get: return [left, right]
var left: ActConnector:
	get: return _connection_state.links[self].left
var right: ActConnector:
	get: return _connection_state.links[self].right


func _init(act: ActState) -> void:
	_connection_state = act
