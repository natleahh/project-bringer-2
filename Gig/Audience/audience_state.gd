class_name AudienceState extends Object

signal revealed_audience(index: int)

var members: Array[Models.ComedyType]
var total: int:
	get:
		return members.size()
var preferences: Models.ComedyVector4:
	get:
		var counts = {
			Models.ComedyType.Witty: 0,
			Models.ComedyType.Absurd: 0,
			Models.ComedyType.Relatable: 0,
			Models.ComedyType.Silly: 0,
		}
		for each in members:
			counts[each] += 1
		return Models.ComedyVector4.new(range(4).map(func (i): return float(counts[Models.ComedyType.values()[i]]) / float(total)))
var known: Array[int] = []

static func random_preference_array() -> Array[float]:
	var data = range(4).map(func (_i): return randf())
	var _total = float(data.reduce(func (a, b): return a + b, 0))
	return data.map(func (a): return float(a) / _total)

static func _count_helper(accumulator: Dictionary[Models.ComedyType, int], type: Models.ComedyType) -> Dictionary[Models.ComedyType, int]:
	accumulator[type as Models.ComedyType] += 1
	return accumulator

func _init(_total: int) -> void:
	var preference_array: Array = random_preference_array()
	var _members: Array[Models.ComedyType] = []
	for i in preference_array.size():
		var _type: Models.ComedyType = Models.ComedyType.values()[i]
		var n: int = int(_total * preference_array[i])
		_members.append_array(range(n).map(func (_i): return _type))
	members = _members
	while members.size() < total:
		members.append(Models.ComedyType.values().pick_random())
	
	members.shuffle()
	pass
	

func reveal(score: float, type: Models.ComedyType):
	if score <= 0:
		return
	var available = range(members.size()).filter(_is_available.bind(type))
	if not available:
		return
	for _i in max(int(score / 10), available.size()):
		known.append(available.pick_random())
		revealed_audience.emit(known[-1])

func _is_available(index: int, type: Models.ComedyType) -> bool:
	return index not in known and members[index] == type
