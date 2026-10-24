class_name ActConnector extends Object

var data: Models.ConnectorData
var texture: Texture2D = PlaceholderTexture2D.new():
	get:
		return data.texture
var position: Vector2:
	get:
		return data.position

## Connection State
var _graph: ActState
var bit: ActNode:
	get: return _graph.connectors[self].node
var link: ActLink:
	get: return _graph.connectors[self].link
var partner: ActConnector:
	get: return null if link == null else link.connectors.filter(_is_self)[0]

func _init(connector_data: Models.ConnectorData, act: ActState) -> void:
	_graph = act
	data = connector_data

func _is_self(connector: ActConnector) -> bool:
	return connector == self
