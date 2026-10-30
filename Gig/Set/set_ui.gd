extends Control

const SET_BIT_UI: PackedScene = preload("res://Gig/Set/set_bit_ui.tscn")

class MissingBitTexture extends PlaceholderTexture2D:
	func _init() -> void:
		size = Vector2.ONE * 32

class JokeBitUI extends TextureRect:
	func _init(_texture: Texture2D) -> void:
		texture = _texture
		expand_mode = TextureRect.EXPAND_KEEP_SIZE
		stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED

@onready var timer: Timer = %Timer

signal score_end

var bits: Dictionary[SetState.SetBit, SetBitUI] = {}
var index: int
var set_history: Array[SetState.SetBit]
var current_joke: Array[SetState.ScoreContext]
var audience_preference: Models.ComedyVector4
var unknown_average: Models.ComedyVector4

func add_preview(preview_bits: Array) -> void:
	for child in %PreviewSet.get_children():
		child.queue_free()
	for preview_bit in preview_bits:
		var preview_bit_ui: SetBitUI = SET_BIT_UI.instantiate()
		preview_bit_ui.state = preview_bit
		add_to_setdisplay(preview_bit_ui, %PreviewSet)

func add_bit(set_bit: SetState.SetBit) -> void:
	bits[set_bit] = SET_BIT_UI.instantiate()
	bits[set_bit].state = set_bit
	add_to_setdisplay(bits[set_bit], %ActiveSet)
	clear_joke_display()

func add_to_setdisplay(set_bit_ui: SetBitUI, set_display: VBoxContainer) -> void:
	set_display.add_child(set_bit_ui)
	set_display.move_child(set_bit_ui, 0)
	queue_redraw()

func add_joke_bit(set_bit: SetState.SetBit, revealed: bool) -> void:
	%JokeDisplay.add_child(
		JokeBitUI.new(
			set_bit._data.texture if revealed else MissingBitTexture.new()
		)
	)

func play_joke(joke: Array[SetState.ScoreContext], set_bits: Array[SetState.SetBit]) -> void:
	current_joke = joke
	set_history = set_bits
	index = 0
	audience_preference = %AudienceUI.state.preferences
	var unknown_triggers = joke.filter(func (sc: SetState.ScoreContext): return not sc.is_revealed)
	var unknown_total = unknown_triggers.reduce(score_sum_helper.bind(audience_preference), 0.0)
	if unknown_triggers:
		unknown_average = (unknown_total as Models.ComedyVector4)._apply(func (n, d): return n / d, unknown_triggers.size())
	update_current_marker()
	timer.start()

func score_sum_helper(score: Variant, sc: SetState.ScoreContext, pref: Models.ComedyVector4) -> Models.ComedyVector4:
	return set_history[sc.target].get_base_score(pref).add(score)

func _on_timer_timeout() -> void:
	if index == current_joke.size():
		timer.stop()
		score_end.emit()
		return

	var score_context := current_joke[index]
	var target := set_history[score_context.target]
	if index == 0:
		queue_redraw()
	if score_context.is_revealed or index == 0:
		add_joke_bit(target, true)
		bits[target].score()
		if score_context.source != 0:
			bits[set_history[score_context.source]].score()
		%ScoreBar.update_score(target.get_base_score(audience_preference, score_context.power))
	else:
		add_joke_bit(target, false)
		%ScoreBar.update_score(unknown_average)
	index += 1
	timer.start()

func clear_joke_display() -> void:
	for each in %JokeDisplay.get_children():
		each.queue_free()
	for bit in bits.values():
		bit.reset()

func update_current_marker() -> void:
	for set_bit_ui in bits.values():
		set_bit_ui.current = false
	if set_history == []:
		return
	bits[set_history[-1]].current = true
