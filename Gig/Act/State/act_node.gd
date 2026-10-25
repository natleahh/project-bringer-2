class_name ActNode extends Object

var data: Models.BitData
var texture: Texture2D = PlaceholderTexture2D.new():
	get:
		return data.texture
var position: Vector2:
	get:
		return data.position

## Connection State
var _graph: ActState
var connectors: Array[ActConnector]:
	get:
		return _graph.nodes[self].connectors

func _init(bit_data: Models.BitData, act: ActState) -> void:
	_graph = act
	data = bit_data

func get_neighbours() -> Array[ActNode]:
	return (
		connectors
		.filter(func (c: ActConnector): return c.partner != null)
		.map(func (c): return c.partner.bit)
	)
