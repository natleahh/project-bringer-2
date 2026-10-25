class_name ConnectorUI extends TextureRect

var state: ActConnector

signal request_selection_start
signal request_selection_end
signal request_selection_confirm


func _unhandled_key_input(event: InputEvent) -> void:				
	handle_connector_select(event)

func handle_connector_select(event: InputEventKey) -> void:
	if not get_rect().has_point(get_global_mouse_position()):
		return
	if event.key_label == KEY_TAB: request_selection_start.emit()
	if event.key_label == KEY_ESCAPE: request_selection_end.emit()
	if event.key_label == KEY_ENTER: request_selection_confirm.emit()
