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
	

func get_bridges() -> Array[ActConnector]:
	return connectors.filter(func (c: ActConnector): return c.partner != null)

func get_neighbours() -> Array[ActConnector]:
	return get_bridges().map(func (c: ActConnector): return c.partner.bit)

func get_active_count() -> int:
	return get_bridges().filter(func (c: ActConnector): return c.link and c.link.active).size()
