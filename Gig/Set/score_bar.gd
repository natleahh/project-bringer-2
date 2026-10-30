class_name ScoreBar extends VBoxContainer

var bars: Array[ColorRect] = []


func _ready() -> void:
	for i in 4:
		bars.append(ColorRect.new())
		bars[-1].color = Models.ComedyColor[i]
		add_child(bars[-1])

func update_score(update: Models.ComedyVector4):
	for i in 4:
		bars[i].custom_minimum_size.y += update._data[i]
