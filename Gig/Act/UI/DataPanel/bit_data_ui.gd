class_name BitDataUI extends PanelContainer

class _CR extends ColorRect:
	func _init(t: Models.ComedyType, s: Vector2) -> void:
		color = Models.ComedyColor[(t as int)]
		custom_minimum_size = s

var data: Models.BitData

func _ready() -> void:
	%Icon.texture = data.texture
	for connector in data.connectors:
		$HBoxContainer.add_child(_CR.new(connector.type, %Icon.custom_minimum_size))

func reset() -> void:
	visible = true

func _get_drag_data(_at_position: Vector2) -> Variant:
	set_drag_preview(self.duplicate(1))
	visible = false
	return self
