class_name ConnectorUI extends ColorRect

var state: ActConnector

func _init() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	custom_minimum_size = Vector2.ONE * 15

func _ready() -> void:
	state.updated.connect(update_state)
	update_state()

func update_state() -> void:
	color = Models.ComedyColor[(state.type as int)]
	modulate = Color.DIM_GRAY if state.partner != null else Color.WHITE

#var selected: bool:
	#get: return %Selector.visible
	#set(val): %Selector.visible = val
#
#func _ready() -> void:
	#mouse_entered.connect(func (): request_editor_command.emit(Editor.Command.new(self, Editor.Command.Type.Start)))
	#mouse_exited.connect(func (): request_editor_command.emit(Editor.Command.new(self, Editor.Command.Type.Stop)))
	#mouse_exited.connect(func (): grab_focus())
	#
#
#func _input(event: InputEvent) -> void:
	#handle_connector_select(event)
#
#func handle_connector_select(event: InputEventKey) -> void:
	#if not get_global_rect().has_point(get_global_mouse_position()):
		#return
	#if event.key_label == KEY_TAB: 
		#request_editor_command.emit(Editor.Command.new(self, Editor.Command.Type.Cycle))
	#if event.key_label == KEY_ESCAPE: request_editor_command.emit(Editor.Command.new(self, Editor.Command.Type.Stop))
	#if event.key_label == KEY_ENTER: request_editor_command.emit(Editor.Command.new(self, Editor.Command.Type.Confirm))
