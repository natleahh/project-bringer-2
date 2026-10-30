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
	var effects: Array[Models.ScoreEffect]:
		get: return _data.effects
	
	func _init(node: ActNode, connector: ActConnector) -> void:
		_data = node.data
		if connector != null:
			type = connector.type

	func call_back(_bits, index):
		for effect in effects:
			if effect is not Models.CallBackEffect:
				continue
			match effect.get_call_back(_bits, index):
				0: pass
				var _index: return ScoreContext.new(effect, index, _index)

	func get_set_up(index: int, _bits: Array[SetState.SetBit], joke: Array[SetState.ScoreContext]) -> Array:
		for effect in effects:
			if effect is not Models.SetUpEffect:
				continue
			match effect.get_set_up(_bits, joke):
				[]: pass
				var _indexes: return _indexes.map(
					func (i): return ScoreContext.new(effect, i, index)
				)
		return []


	func get_exponent(power: float = 0) -> Models.ComedyVector4:
		return Models.ComedyVector4.get_exponent(10.0 + power, [type])

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
	
	joke.append_array(current_bit.get_set_up(index, bits, joke))
	var is_retrigger = (index == -1) or (index not in joke.map(func (sc: ScoreContext): return sc.target))
	if is_retrigger:
		return build_joke(index - 1, joke)
	match current_bit.call_back(bits, index):
		null: 
			pass
		var score_context:
			joke.append(score_context)
	return build_joke(index - 1, joke)
