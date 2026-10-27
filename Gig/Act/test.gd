extends Node2D

@onready var act_state: ActState = %ActState
@onready var act_player: ActPlayer = %ActPlayer
@onready var viewer: Viewer = %Viewer

func _on_act_state_changed() -> void:
	act_player.tick()
	if act_player.connector:
		viewer.currect_connector = act_player.connector
	viewer.update_connector_path()


func _on_act_state_new_bit(node: ActNode) -> void:
	viewer.add_bit(node)

func _on_act_state_new_link(link: ActLink) -> void:
	viewer.add_link(link)

func _on_viewer_create_link(left: ActConnector, right: ActConnector) -> void:
	act_state.link_connectors(left, right)

func _on_viewer_play_connector(connector: ActConnector) -> void:
	act_player.play_from_connector(connector)
	viewer.update_connector_path()

func _on_viewer_toggle_link(link: ActLink) -> void:
	act_state.toggle_link(link)

func _on_data_dock_dropped_bit(bit_data: BitDataUI, at_position: Vector2) -> void:
	bit_data.data.position = at_position
	act_state.add_bit(bit_data.data)
	bit_data.queue_free()
