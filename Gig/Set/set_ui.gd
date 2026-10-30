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

func add_bit(set_bit: SetState.SetBit) -> void:
	bits[set_bit] = SET_BIT_UI.instantiate()
	bits[set_bit].state = set_bit
	%SetDisplay.add_child(bits[set_bit])
	clear_joke_display()

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
