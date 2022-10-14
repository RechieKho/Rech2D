extends Reference

"""A Stack of array. """

class_name ArrayTower

### VARIABLE ###

var _tower = {}
var top_array setget set_top_array, get_top_array
var top_value setget set_top_value, get_top_value

### FUNCTION ###
# --- Public ---

func set_top_array(value):
	_tower[get_top_level()] = value

func get_top_array() -> Array:
	return get_array(get_top_level())

func set_top_value(value):
	var top_arr = get_top_array()
	if len(top_arr):
		top_arr[0] = value
	else:
		top_arr.push_front(value)

func get_top_value():
	var top_arr = get_top_array()
	return top_arr[0] if len(top_arr) > 0 else null

func get_array(level: int) -> Array:
	if not(level in _tower.keys()):
		_tower[level] = []
	return _tower[level]

func erase_array(level: int):
	_tower.erase(level)

func get_top_level():
	var keys = _tower.keys()
	keys.sort()
	keys.invert()
	for key in keys:
		if len(_tower[key]):
			return key
	return 0

