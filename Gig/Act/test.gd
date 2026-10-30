extends Node2D

const MAX_BITS: int = 10
const MAX_CHANGES: int = 20

var changes: int = 0
var bits: int:
	get: return set_state.bits.size()

var is_scoring: bool = false

@onready var act_state: ActState = %ActState
@onready var act_player: ActPlayer = %ActPlayer
@onready var viewer: Viewer = %Viewer
@onready var set_state: SetState = %SetState


func update_preview() -> void:
	var preview_act = act_player.get_preview(MAX_BITS - bits)
	var preview_set = preview_act.map(func (c: ActConnector): return SetState.SetBit.new(c.bit, c))
	%SetUI.add_preview(preview_set)

func _on_act_state_changed() -> void:
	update_preview()
	#viewer.update_connector_path()ath()

func _on_act_state_new_bit(node: ActNode) -> void:
	if changes >= MAX_CHANGES:
		return 
	changes += 1
	viewer.add_bit(node)

func _on_act_state_new_link(link: ActLink) -> void:
	changes += 1
	viewer.add_link(link)

func _on_viewer_create_link(left: ActConnector, right: ActConnector) -> void:
	if changes >= MAX_CHANGES:
		return
	act_state.link_connectors(left, right)

func _on_viewer_play_bit(bit: ActNode) -> void:
	if changes >= MAX_CHANGES:
		return
	if act_player.node != null:
		return
	viewer.current_node = bit
	viewer.queue_redraw()
	act_player.play(bit, is_scoring)
	set_state.add_bit(bit, null)
	update_preview()
	#set_state.score(%AudienceUI.state.preferences)
	#viewer.update_connector_path()

func _on_viewer_progress_player() -> void:
	if changes >= MAX_CHANGES or set_state.bits.size() >= MAX_BITS:
		return
	act_player.play_next(is_scoring)
	update_preview()

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
	#set_state.score(%AudienceUI.state.preferences)

func _on_set_state_added_bit(bit: SetState.SetBit) -> void:
	%SetUI.add_bit(bit)

func _on_set_state_added_joke(joke: Array[SetState.ScoreContext]) -> void:
	is_scoring = true
	%SetUI.play_joke(joke, set_state.bits)

func _on_set_ui_score_end() -> void:
	is_scoring = false

func _process(_delta: float) -> void:
	%BitsLeft.text = "%s jokes out of %s left in your set" % [MAX_BITS - bits, MAX_BITS]
	%MovesLeft.text = "%s chages out of %s left you can make to your act" % [MAX_CHANGES - changes, MAX_CHANGES]
