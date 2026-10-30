class_name SetBitUI extends TextureRect

var state: SetState.SetBit
var tween: Tween

func _ready() -> void:
	expand_mode = TextureRect.EXPAND_FIT_WIDTH
	update_state()

func update_state() -> void:
	texture = state._data.texture
	%ColorRect.color = Models.get_comedy_type_color(state.type)
	tooltip_text = "\n".join(
		state.effects.map(func (e: Models.ScoreEffect): 
			return e.text if e.triggers >= e.threshold else "?".repeat(20))
	)

func score() -> void:
	modulate = Color.WHITE
	if tween: tween.kill()
	
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "rotation", PI / 4, 0.1)
	tween.tween_property(self, "rotation", 0, 0.1)
	tween.chain()
	update_state()

func reset() -> void:
	modulate = Color.DIM_GRAY
