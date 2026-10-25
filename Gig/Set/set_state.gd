class_name SetState extends Node

var bits: Array[SetBit] = []
var jokes: Array[Array] = []

var start: Variant = null

signal added_bit(bit: SetBit)
signal added_joke(joke: Array[int])

class SetBit:
	var bit: Models.BitData
	var type: Models.ComedyType

func add_bit(bit: SetBit) -> void:
	bits.append(bit)
	added_bit.emit(bit)

func add_joke(joke: Array[int]) -> void:
	jokes.append(joke)
	added_joke.emit(joke)

func set_up(bit: SetBit) -> void:
	start = bits.size()
	add_bit(bit)

func drop() -> void:
	start = null

func pay_off(bit: SetBit) -> void:
	if start == null:
		return 
	add_bit(bit)
	add_joke(bits.slice(start, bits.size()))
	
