class_name Models extends Object

enum ComedyType {Witty, Absurd, Relatable, Silly}

const ComedyColor: Array[Color] = [Color("blue"), Color("green"), Color("orange"), Color("red")]

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
