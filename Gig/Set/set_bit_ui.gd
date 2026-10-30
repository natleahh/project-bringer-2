class_name SetBitUI extends TextureRect

var state: SetState.SetBit
var tween: Tween
var current: bool:
	get: return %Current.visible
	set(b): %Current.visible = b


func _ready() -> void:
	expand_mode = TextureRect.EXPAND_FIT_WIDTH
	if state: update_state()

func update_state() -> void:
	texture = state._data.texture
	%ColorRect.color = Models.get_comedy_type_color(state.type)
	tooltip_text = "\n".join(
		state.effects.map(func (e: Models.ScoreEffect): 
			return e.text if e.triggers >= e.threshold else "?".repeat(20))
	)

func score() -> void:
	modulate = Color.LIGHT_YELLOW
	if tween: tween.kill()

	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "rotation", PI / 4, 0.1)
	tween.tween_property(self, "rotation", 0, 0.1)
	tween.chain()
	update_state()

func reset() -> void:
	modulate = Color.WHITE

func _on_button_toggled(toggled_on: bool) -> void:
	visible = toggled_on
