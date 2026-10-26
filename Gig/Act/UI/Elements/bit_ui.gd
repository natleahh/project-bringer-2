class_name BitUI extends RigidBody2D

const CONNECTOR_UI: PackedScene = preload("res://Gig/Act/UI/Elements/connector_ui.tscn")

signal moved

var state: ActNode
var shape: RectangleShape2D:
	get: return %Collision.shape

var ui_connectors: Array[ConnectorUI] = []

func get_global_rect() -> Rect2:
	return %NodeUI.get_global_rect()

func _ready() -> void:
	for connector in state.connectors:
		var connector_ui: ConnectorUI = CONNECTOR_UI.instantiate()
		connector_ui.state = connector
		ui_connectors.append(connector_ui)
		%ConnectorsUI.add_child(connector_ui)
	
	# Input func
	%NodeUI.mouse_entered.connect(func (): mouse_entered.emit())
	%NodeUI.mouse_exited.connect(func (): mouse_exited.emit())
	
	# Collision
	%NodeUI.button_down.connect(func (): freeze = true)
	%NodeUI.button_up.connect(func (): freeze = false)
	body_entered.connect(func (): moved.emit())
	shape.size = %NodeUI.get_rect().size
	

## Movement Handling
func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		moved.emit()

func _physics_process(_delta: float) -> void:
	if freeze:
		global_transform.origin = get_global_mouse_position()

## State Updating
func refresh_state() -> void:
	%Icon.texture = state.texture
