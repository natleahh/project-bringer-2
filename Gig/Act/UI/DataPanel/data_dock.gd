extends Control

const BIT_DATA_UI = preload("res://Gig/Act/UI/DataPanel/bit_data_ui.tscn")

signal dropped_bit(bit_data: BitDataUI, at_position: Vector2)

func _ready() -> void:
	for data in 5:
		var bit_data_ui : BitDataUI = BIT_DATA_UI.instantiate()
		bit_data_ui.data = Models.BitData.get_random()
		%BitDataDisplay.add_child(bit_data_ui)

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is BitDataUI

func _drop_data(at_position: Vector2, data: Variant) -> void:
	dropped_bit.emit(data, at_position)

func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_BEGIN: mouse_filter = Control.MOUSE_FILTER_STOP
	if what == NOTIFICATION_DRAG_END: mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	
