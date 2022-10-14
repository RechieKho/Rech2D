extends Reference

class_name SmoothProp

### VARIABLE ###

var transition_type: int
var ease_type: int

var _twn: Tween
var _property: String
var _object: Object

func _init(
	twn: Tween, 
	object: Object, 
	property: String, 
	default_transition_type = Env.TWEEN_TRANSITION_TYPE,
	default_ease_type = Env.TWEEN_EASE_TYPE
	):
	_twn = twn
	_property = property
	_object = object
	transition_type = default_transition_type
	ease_type = default_ease_type

func smoothly_change_to(new_value, duration: float, delay=0):
	_twn.stop_all()
	_twn.interpolate_property(
		_object,
		_property,
		_object.get(_property),
		new_value,
		duration,
		transition_type,
		ease_type,
		delay
	)
	_twn.start()
