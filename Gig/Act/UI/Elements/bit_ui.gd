@tool
class_name BitUI extends RigidBody2D

const CONNECTOR_UI: PackedScene = preload("")

signal moved
signal request_selection_start
signal request_selection_end
signal request_link_scroll
signal request_link_confirm


var state: ActNode
var selected: bool:
	set(val): %HoverSelect.visible = val
	get: return %HoverSelect.visible

var ui_connectors: Array[ConnectorUI]
	
func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey: handle_selection_input(event)

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton: handle_movement_input(event)

func handle_movement_input(event: InputEventMouseButton) -> void:
	if event.button_index == MOUSE_BUTTON_LEFT:
		freeze = event.is_pressed()

func handle_selection_input(event: InputEventKey) -> void:
	if event.key_label == KEY_TAB:
		request_link_scroll.emit()
	elif event.key_label == KEY_SPACE:
		request_link_confirm.emit()

func _mouse_enter() -> void:
	request_selection_start.emit()

func _mouse_exit() -> void:
	request_selection_end.emit()

func _ready() -> void:
	body_entered.connect(func (): moved.emit())
	
	$CollisionShape2D.shape = RectangleShape2D.new()
	$CollisionShape2D.shape.size = $BitNode.get_rect().size

	for connector in state.connectors:
		var connector_ui: ConnectorUI = CONNECTOR_UI.instant

func refresh_state() -> void:
	%Icon.texture = state.texture

func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		moved.emit()

func _physics_process(_delta: float) -> void:
	if freeze:
		global_transform.origin = get_global_mouse_position()


func _on_texture_rect_mouse_exited() -> void:
	pass # Replace with function body.
