class_name ActConnector extends Object

signal updated

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
	get: return null if link == null else link.connectors.filter(_is_other)[0]

func _init(connector_data: Models.ConnectorData, act: ActState) -> void:
	_connection_state = act
	data = connector_data

func _is_other(connector: ActConnector) -> bool:
	return connector != self

func is_compatible(connector: ActConnector) -> bool:
	if self == connector:
		return false
	if type != connector.type:
		return false
	if bit == connector.bit:
		return false
	#if bit in connector.bit.get_neighbours():
		#return false 
	return true

func already_connected(node: ActNode) -> Array[ActConnector]:
	var partners = node.linked_connectors.map( func (c): return c.partner)
	return partners.filter(func (c): return c.bit == node and c != self)

func get_connected_bit() -> ActNode:
	if link == null or not link.active:
		return
	return partner.bit

func get_compatible_connectors() -> ActConnector:
	return 

func get_compatible() -> Array[ActConnector]:
	return _connection_state.connectors.keys().filter(is_compatible)

func connector_path(connector: ActConnector = null, source: ActConnector = null, chain: Array = []) -> Array:
	if connector == null and source == null:
		return connector_path(self, self, chain)
	if source in chain:
		return chain
	var next = connector.bit.get_bridges().filter(func (c: ActConnector): return c.link.active and c != connector)
	if next.size() != 1:
		return chain
	return connector_path(next[0].partner, source, chain + [connector])
