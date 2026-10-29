extends HBoxContainer

class _L extends Label:
	func _init(type: Models.ComedyType, parent: Node) -> void:
		text = "0"
		label_settings = LabelSettings.new()
		label_settings.font_color = Models.ComedyColor[type as int]
		parent.add_child(self)

@onready var labels: Array = Models.ComedyType.values().map(
	_L.new.bind(self)
)

func update_score(score: Models.ComedyVector4) -> void:
	for i in 4:
		labels[i].text = "%.2f" % score._data[i]
