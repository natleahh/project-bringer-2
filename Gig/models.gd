class_name Models extends Object

enum ComedyType {Witty, Absurd, Relatable, Silly}

const ComedyColor: Array[Color] = [Color("blue"), Color("green"), Color("orange"), Color("red")]

const TEXTURES: Array[CompressedTexture2D] = [
	## just for now ok? <3
	## ( ͡° ͜ʖ ͡°)
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E1.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E2.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E3.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E4.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E5.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E6.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E7.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E8.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E9.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E10.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E11.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E12.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E13.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E14.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E15.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E16.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E17.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E18.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E19.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E20.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E21.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E22.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E23.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E24.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E25.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E26.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E27.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E28.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E29.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E30.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E31.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E32.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E33.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E34.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E35.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E36.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E37.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E38.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E39.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E40.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E41.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E42.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E43.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E44.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E45.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E46.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E47.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E48.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E49.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E50.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E51.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E52.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E53.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E54.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E55.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E56.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E57.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E58.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E59.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E60.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E61.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E62.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E63.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E64.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E65.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E66.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E67.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E68.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E69.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E70.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E71.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E72.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E73.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E74.png"),
	preload("res://assets/free-emojis-pixelart/emojis-x1-32x32/E75.png"),
]

class ComedyVector4:
	var _data: Array = [null, null, null, null]
	
	var witty:
		get: return _get_by_comedy_type(ComedyType.Witty)
		set(type): _set_by_comedy_type(ComedyType.Witty, type)
		
	var absurd:
		get: return _get_by_comedy_type(ComedyType.Absurd)
		set(type): _set_by_comedy_type(ComedyType.Absurd, type)
		
	var relatable:
		get: return _get_by_comedy_type(ComedyType.Relatable)
		set(type): _set_by_comedy_type(ComedyType.Relatable, type)
		
	var silly:
		get: return _get_by_comedy_type(ComedyType.Silly)
		set(type): _set_by_comedy_type(ComedyType.Silly, type)
	
	func _init(data: Array) -> void:
		if data.size() != 4:
			push_error("Must be an array of size 4")
		_data = data
		pass

	func _get_by_comedy_type(type: ComedyType) -> Variant:
		return _data[type as int]
	
	func _set_by_comedy_type(type: ComedyType, val: float) -> void:
		_data[type as int] = val
	
	static func _apply_each(callable: Callable, a: Array, b: Array) -> ComedyVector4:
		return ComedyVector4.new(range(4).map(func (i): return callable.call(a[i], b[i])))
	
	func _apply(callable: Callable, variant: Variant) -> ComedyVector4:
		if variant is ComedyVector4:
			return ComedyVector4._apply_each(callable, _data, variant._data)
		if variant is Array:
			return ComedyVector4._apply_each(callable, _data, variant)
		else:
			return ComedyVector4.new(_data.map(func (each): return callable.call(each, variant)))
	
	static func get_exponent(num: float, types: Array[ComedyType]) -> ComedyVector4:
		var e = ComedyVector4.new([1.0, 1.0, 1.0, 1.0])
		types.map(func (t): e._set_by_comedy_type(t, num))
		return e
	
	func add(other: Variant) -> ComedyVector4:
		return _apply(func (a, b): return a + b, other)
	
	func power(exponent: Variant) -> ComedyVector4:
		return _apply(func (base, _exp): return pow(base, _exp), exponent)

class ScoreEffects extends Resource:
	var call_back: CallBackEffect
	var set_up: SetUpEffect
	
	static func randomise() -> ScoreEffects:
		var se := ScoreEffects.new()
		se.call_back = CallBackEffect.randomise()
		se.set_up = SetUpEffect.randomise()
		
		return se

@abstract
class ScoreEffect extends Resource:
	var triggers: int = 0
	var threshold: int = 0
	var text: String: 
		get: return "[color=black]%s[/color]" % [get_format_text()]
	var power: float: get = _power
	
	@abstract func get_format_text() -> String
	
	@abstract func _power() -> float

class OpenerEffect extends ScoreEffect:
	
	func _power() -> float:
		return 1.0
	
	func get_format_text() -> String:
		return "The Bit Opener"

class CallBackEffect extends ScoreEffect:
	var type: ComedyType
	var num: int

	func _init(_type: ComedyType, _num: int) -> void:
		type = _type
		num = _num
	
	func _power() -> float:
		return float(num)
	
	func get_format_text() -> String:
		if type == null:
			return "Triggers any bit %s places this bit" % [num]
		else:
			return "Triggers a %s bit that is %s places before this bit" % [Models.get_formatted_comedy_type_name(type), num]

	func get_call_back(bits: Array[SetState.SetBit], index: int) -> int:
		var cb_index = index - num
		if abs(cb_index) > bits.size():
			return 0
		elif bits[cb_index].type == type:
			triggers += 1
			return cb_index
		else:
			return 0

	static func randomise() -> CallBackEffect:
		return CallBackEffect.new(ComedyType.values()[randi() % 4], randi_range(1, 3))

class SetUpEffect extends ScoreEffect:
	var type: ComedyType
	var exact: bool
	var count: int
	
	func _init(_type: ComedyType, _exact: int, _count: int) -> void:
		type = _type
		exact = _exact
		count = _count
	
	func _power() -> float:
		return float(count)

	func get_format_text() -> String:
		var cond: StringName
		if exact:
			cond = "if exactly"
		else:
			cond = "at least"
		var key = Models.get_formatted_comedy_type_name(type)
		return "Triggers this bit if %s %s %s bits are ahead of it" % [cond, count, key]
	
	func get_set_up(bits: Array[SetState.SetBit], joke: Array[SetState.ScoreContext]) -> Array[int]:
		var matching = joke.filter(func (sc: SetState.ScoreContext): return bits[sc.target].type == type)
		if (matching.size() == count and exact) or (matching.size() >= count and not exact):
			count += 1
			return matching.map(func (sc: SetState.ScoreContext): return sc.target) as Array[int]
		return [] as Array[int]
	static func randomise() -> SetUpEffect:
		var c = randi_range(1, 2)
		return SetUpEffect.new(ComedyType.values()[randi() % 4], c, c)

class BitData extends Resource:
	var texture: Texture2D = PlaceholderTexture2D.new()
	var position: Vector2 = Vector2.ZERO
	var connectors: Array
	var effects: ScoreEffects

	func _init(_connectors: Array, _texture: Texture2D, _effects: ScoreEffects) -> void:
		connectors = _connectors 
		texture = _texture
		effects = _effects
		
	static func get_random() -> BitData:
		return BitData.new(
			range(randi_range(3, 4)).map(func (_i): return ConnectorData.get_random()),
			TEXTURES[randi() % TEXTURES.size()],
			ScoreEffects.randomise()
		)


class ConnectorData extends Resource:
	var type: ComedyType = ComedyType.Witty
	
	func _init(_type: Models.ComedyType) -> void:
		type = _type
	
	static func get_random() -> ConnectorData:
		return ConnectorData.new(ComedyType.values().pick_random())
		

static func get_comedy_type_color(type: ComedyType) -> Color:
	return ComedyColor[(type as int)]

static func get_comedy_type_name(type: ComedyType) -> String:
	return ComedyType.keys()[type as int]

static func get_formatted_comedy_type_name(type: ComedyType) -> String:
	return "[color=%s]%s[/color]" % [get_comedy_type_color(type).to_html(), get_comedy_type_name(type)]
