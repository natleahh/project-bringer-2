class_name AudienceUI extends HFlowContainer

const LAUGHTER_SPOT = preload("res://Gig/Audience/laughter_spot.tscn")

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
	for i in 4:
		_laugh_helper(score._data[i], (i as Models.ComedyType))

func _laugh_helper(score: float, type: Models.ComedyType) -> void:
	if score == 0:
		return
	state.reveal(score, type)
	var shuffled = _get_shuffled_memebers(type)
	var slice = shuffled.slice(0, randi() % shuffled.size())
	var laughs_per_member = score / slice.size()
	for i in slice:
		laughter_spots[i].amount = max(int(laughs_per_member), 1)
		laughter_spots[i].emitting = true



func _get_shuffled_memebers(type: Models.ComedyType) -> Array:
	var temp: Array = range(total).filter(func (i): return state.members[i] == type)
	temp.shuffle()
	return temp

func _on_audience_reveal(member_index: int) -> void:
	var color: Color = Models.ComedyColor[state.members[member_index] as int]
	laughter_spots[member_index].color = color
