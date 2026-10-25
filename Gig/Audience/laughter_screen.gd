class_name LaughScreen extends HFlowContainer

const LAUGHTER_SPOT = preload("res://Set/Audience/laughter_spot.tscn")

var laughter_spots: Array[LaughterSpot] = []
var state: AudienceState
var total: int:
	get: return state.total

func _ready() -> void:
	
	var area = Vector2i(get_rect().size)
	var each = Vector2i.ONE * area.y / 3
	var grid = area / each
	
	state = AudienceState.new(grid.x * grid.y)
	
	for i in range(total):
		laughter_spots.append(LAUGHTER_SPOT.instantiate())
		laughter_spots[-1].custom_minimum_size = each
		add_child(laughter_spots[-1])
	
	state.revealed_audience.connect(_on_audience_reveal)


func laugh(score: Models.ComedyVector4) -> void:
	state.reveal(score)

	for i in _get_shuffled_memebers().slice(0, int(total * randf())):
		laughter_spots[i].emitting = true

func _get_shuffled_memebers() -> Array:
	var temp: Array = range(total)
	temp.shuffle()
	return temp

func _on_audience_reveal(member_index: int) -> void:
	var color: Color = Models.ComedyColor[state.members[member_index] as int]
	laughter_spots[member_index].color = color
