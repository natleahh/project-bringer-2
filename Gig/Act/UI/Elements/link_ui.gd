@tool
class_name LinkUI extends Node2D

signal clicked(button_index: int)

@export var area_2d: Area2D
@export var collision_polygon_2d: CollisionPolygon2D

@export var node_a: BitUI
@export var node_b: BitUI

@export var points: Array[Vector2]

@export var width: float = 5

var state: ActLink 
var active: bool = false
	#get: return state.active
var colour: Color = Color.WHITE
	#get: return Models.ComedyColor[state.left.data.type as int]

func _ready() -> void:
	#state.changed.connect(_on_moved)
	node_a.moved.connect(_on_moved)
	node_b.moved.connect(_on_moved)
	
func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is not InputEventMouseButton:
		return
	if not event.is_pressed():
		return
	clicked.emit(event.button_index)

func _on_moved() -> void:
	points = [to_local(node_a.global_position), to_local(node_b.global_position)]
	_update_polygon()
	queue_redraw()
	
func width_polygon(_width: float) -> PackedVector2Array:
	var width_v = points[0].direction_to(points[1]).rotated(PI / 2) * width
	return PackedVector2Array([
		points[0] + width_v,
		points[0] - width_v,
		points[1] - width_v,
		points[1] + width_v,
	])

func _update_polygon() -> void:
	collision_polygon_2d.polygon = width_polygon(width)

func _draw() -> void:
	draw_colored_polygon(collision_polygon_2d.polygon, colour)
