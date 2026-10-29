class_name SetState extends Node

var bits: Array[SetBit] = []
var jokes: Array[Array] = []

var start: Variant = null

signal added_bit(bit: SetBit)
signal added_joke(joke: Array[int])
signal score_update(update: Models.ComedyVector4)

var _score: Models.ComedyVector4 = Models.ComedyVector4.new([0.0, 0.0, 0.0, 0.0])
@export var score_each: Array[float]:
	get: return _score._data.map(func (v): return float(v))
@export var score_sum: float:
	get: return score_each.reduce(func (a, b): return a + b, 0.0)

class SetBit:
	var bit: Models.BitData
	var type: Models.ComedyType
	
	func _init(node: ActNode, connector: ActConnector) -> void:
		bit = node.data
		if connector != null:
			type = connector.type

func add_bit(node: ActNode, connector: ActConnector) -> void:
	bits.append(
		SetState.SetBit.new(node, connector)
	)

func score(audience_preference: Models.ComedyVector4, index: int = -1) -> void:
	if -index > bits.size():
		return
		
	var exponents = range(4).map(
		func (i): return 5 if bits[index].type == null or bits[index].type == Models.ComedyType.values()[i] else 0
	)
	
	var _score_update = audience_preference.add(1).power(exponents).add(-1)
	_score = _score.add(_score_update)
	score_update.emit(_score_update)
	
	if bits[index].bit.call_back != 0:
		var callback_index = index - bits[index].bit.call_back
		score(audience_preference, callback_index)

		
		
		
		

	
	
	
	
	
