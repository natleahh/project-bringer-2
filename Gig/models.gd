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

class BitData extends Resource:
	var texture: Texture2D = PlaceholderTexture2D.new()
	var position: Vector2 = Vector2.ZERO
	var connectors: Array
	
	func _init(_connectors: Array, _texture: Texture2D) -> void:
		connectors = _connectors 
		texture = _texture
	
	static func get_random() -> BitData:
		return BitData.new(
			range(randi_range(3, 4)).map(func (_i): return ConnectorData.get_random()),
			TEXTURES[randi() % TEXTURES.size()]
		)

class ConnectorData extends Resource:
	var type: ComedyType = ComedyType.Witty
	
	func _init(_type: Models.ComedyType) -> void:
		type = _type
	
	static func get_random() -> ConnectorData:
		return ConnectorData.new(ComedyType.values().pick_random())
		
