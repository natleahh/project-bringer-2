class_name BitUI extends RigidBody2D

const CONNECTOR_UI: PackedScene = preload("res://Gig/Act/UI/Elements/connector_ui.tscn")

signal moved

var state: ActNode 
var shape: RectangleShape2D:
	get: return %Collision.shape

var ui_connectors: Array[ConnectorUI] = []
var ui_effects: Array[Label] = []

func get_global_rect() -> Rect2:
	return %NodeUI.get_global_rect()

func _ready() -> void:
	%Icon.texture = state.data.texture
	for connector in state.connectors:
		var connector_ui: ConnectorUI = CONNECTOR_UI.instantiate()
		connector_ui.state = connector
		ui_connectors.append(connector_ui)
		%ConnectorsUI.add_child(connector_ui)
	
	for effect in [state.data.effects.call_back, state.data.effects.set_up].filter(func (e): return e != null):
		var effect_ui = RichTextLabel.new()
		effect_ui.bbcode_enabled = true
		effect_ui.text = effect.text
		effect_ui.fit_content = true
		effect_ui.mouse_filter = Control.MOUSE_FILTER_IGNORE
		%EffectText.add_child(effect_ui)
	
	# Input func
	%NodeUI.mouse_entered.connect(func (): mouse_entered.emit())
	%NodeUI.mouse_exited.connect(func (): mouse_exited.emit())
	
	# Collision
	%NodeUI.button_down.connect(func (): freeze = true)
	%NodeUI.button_up.connect(func (): freeze = false)
	body_entered.connect(_on_collision)
	shape.size = %NodeUI.get_rect().size

func _on_collision(_body: Node) -> void:
	moved.emit()

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
