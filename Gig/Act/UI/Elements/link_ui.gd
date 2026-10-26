class_name LinkUI extends Node2D

var width: float = 5

var state: ActLink
var active: bool:
	get: return state.active
var colour: Color:
	get:
		var c_i: int = (state.left.data.type as int)
		var c = Models.ComedyColor[c_i]
		if active:
			return c
		else:
			return c.blend(Color(0.5, 0.5, 0.5, 0.5))

var left: BitUI
var right: BitUI
var points: Array[Vector2]:
	get: return [to_local(left.global_position), to_local(right.global_position)]
var polygon: PackedVector2Array:
	get: return width_polygon()



func _init(_state: ActLink, _left: BitUI, _right: BitUI) -> void:
	state = _state
	state.unlinked.connect(func (): queue_free())
	state.updated.connect(queue_redraw)
	
	left = _left
	right = _right
	left.moved.connect(queue_redraw)
	right.moved.connect(queue_redraw)

func width_polygon(padding: float = 0.0) -> PackedVector2Array:
	var width_v = points[0].direction_to(points[1]).rotated(PI / 2) * (width + padding)
	return PackedVector2Array([
		points[0] + width_v,
		points[0] - width_v,
		points[1] - width_v,
		points[1] + width_v,
	])

func _draw() -> void:
	draw_colored_polygon(polygon, colour)
