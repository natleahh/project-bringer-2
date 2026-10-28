extends Node2D

@onready var act_state: ActState = %ActState
@onready var act_player: ActPlayer = %ActPlayer
@onready var viewer: Viewer = %Viewer
@onready var set_state: SetState = %SetState

func _on_act_state_changed() -> void:
	act_player.tick()
	viewer.update_connector_path()

func _on_act_state_new_bit(node: ActNode) -> void:
	viewer.add_bit(node)

func _on_act_state_new_link(link: ActLink) -> void:
	viewer.add_link(link)

func _on_viewer_create_link(left: ActConnector, right: ActConnector) -> void:
	act_state.link_connectors(left, right)

func _on_viewer_play_bit(bit: ActNode) -> void:
	act_player.play(bit)
	set_state.add_bit(bit, null)
	set_state.score(%AudienceUI.state.preferences)
	viewer.update_connector_path()
	

func _on_viewer_toggle_link(link: ActLink) -> void:
	act_state.toggle_link(link)

func _on_data_dock_dropped_bit(bit_data: BitDataUI, at_position: Vector2) -> void:
	bit_data.data.position = at_position
	act_state.add_bit(bit_data.data)
	bit_data.queue_free()

func _on_act_player_tock() -> void:
	viewer.current_connector = act_player.connector
	viewer.current_node = act_player.node
	set_state.add_bit(act_player.node, act_player.connector)
	set_state.score(%AudienceUI.state.preferences)

func _on_set_state_score_update(_update: Models.ComedyVector4) -> void:
	%TotalScore.text = str(set_state.score_sum)
	%ScoreDisplay.update_score(set_state._score)
	%AudienceUI.laugh(_update)

func _process(_delta: float) -> void:
	%PlayerDisplay.texture = act_player.play_display
	%ProgressBar.value = act_player.progress
