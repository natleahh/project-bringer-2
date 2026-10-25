class_name ActConnector extends Object

## Data State
var data: Models.ConnectorData
var type: Models.ComedyType:
	get: return data.type

## Connection State
var _connection_state: ActState
var _state_fields: ActState.ConnectorFields:
	get: return _connection_state.connectors[self]
var bit: ActNode:
	get: return _state_fields.node
var link: ActLink:
	get: return _state_fields.link
var partner: ActConnector:
	get: return null if link == null else link.connectors.filter(_is_self)[0]

func _init(connector_data: Models.ConnectorData, act: ActState) -> void:
	_connection_state = act
	data = connector_data

func _is_self(connector: ActConnector) -> bool:
	return connector == self

func is_compatible(connector: ActConnector) -> bool:
	return (
		self != connector and
		type == connector.type and
		bit != connector.bit and
		bit not in connector.bit.get_neighbours()
	)

func get_compatible() -> Array[ActConnector]:
	return _connection_state.connectors.keys().filter(is_compatible)
	
