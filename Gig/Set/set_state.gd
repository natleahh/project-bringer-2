class_name SetState extends Node

var bits: Array[SetBit] = []
var jokes: Array[Array] = []

var start: Variant = null

signal added_bit(bit: SetBit)
signal added_joke(joke: Array[ScoreContext])

var _score: Models.ComedyVector4 = Models.ComedyVector4.new([0.0, 0.0, 0.0, 0.0])
@export var score_each: Array[float]:
	get: return _score._data.map(func (v): return float(v))
@export var score_sum: float:
	get: return score_each.reduce(func (a, b): return a + b, 0.0)

class ScoreContext:
	var effect: Models.ScoreEffect
	var source: int
	var target: int
	var power: float:
		get: return effect.power
	
	var is_revealed: bool:
		get: return effect.triggers >= effect.threshold
	
	func _init(_effect: Models.ScoreEffect, _source: int, _target: int) -> void:
		effect = _effect
		source = _source
		target = _target

class SetBit:

	var _data: Models.BitData
	var type: Models.ComedyType
	var call_back_effect: Models.CallBackEffect:
		get: return _data.effects.call_back
	var set_up_effect: Models.SetUpEffect:
		get: return _data.effects.set_up
	var effects: Array[Models.ScoreEffect]:
		get: return [call_back_effect, set_up_effect].filter(func (e): return e != null)
	
	func _init(node: ActNode, connector: ActConnector) -> void:
		_data = node.data
		if connector != null:
			type = connector.type
	
	func call_back(_bits, index) -> int:
		return _data.effects.call_back.get_call_back(_bits, index)
	
	func get_set_up(_bits: Array[SetState.SetBit], joke: Array[SetState.ScoreContext]) -> Array[int]:
		if not set_up_effect: return [] as Array[int]
		return _data.effects.set_up.get_set_up(_bits, joke)

	func get_exponent(power: float = 0) -> Models.ComedyVector4:
		return Models.ComedyVector4.get_exponent(7.0 + power, [type])

	func get_base_score(preference: Models.ComedyVector4, power: float = 0) -> Models.ComedyVector4:
		var exponent = get_exponent(power)
		return preference.add(1).power(exponent)

func add_bit(node: ActNode, connector: ActConnector) -> void:
	bits.append(
		SetState.SetBit.new(node, connector)
	)
	added_bit.emit(bits[-1])
	jokes.append(
		build_joke()
	)
	added_joke.emit(jokes[-1])


func build_joke(index: int = -1, joke: Array[ScoreContext] = []) -> Array[ScoreContext]:
	if -index > bits.size():
		return joke
	if index == -1:
		joke.append(
			ScoreContext.new(Models.OpenerEffect.new(), 0, -1)
		)
	var current_bit = bits[index]
	var set_up: Array = current_bit.get_set_up(bits, joke)
	joke.append_array(
		set_up.map(func (i): return ScoreContext.new(current_bit.set_up_effect, i, index))
	)
	var is_retrigger = (index == -1) or (index not in joke.map(func (sc: ScoreContext): return sc.target))

	match current_bit.call_back(bits, index):
		null: pass
		var cbi when cbi != 0 and is_retrigger: joke.append(
			ScoreContext.new(current_bit._data.effects.call_back, index, cbi)
		)
	return build_joke(index - 1, joke)
