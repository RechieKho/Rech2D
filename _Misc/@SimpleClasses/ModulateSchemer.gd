extends Reference

class_name ModulateSchemer

### VARIABLES ###

var transition_type: int
var ease_type: int
var use_self_modulate := true

var _targets : Array # CanvasItems
var _modulate_schemes : PoolColorArray

var _twn : Tween

### FUNCTIONS ###
func _init(
	twn: Tween, 
	targets: Array, 
	modulate_schemes: PoolColorArray,
	default_use_self_modulate := true,
	default_transition_type := Env.TWEEN_TRANSITION_TYPE,
	default_ease_type := Env.TWEEN_EASE_TYPE
	):
	_twn = twn
	_targets = targets
	_modulate_schemes = modulate_schemes
	use_self_modulate = default_use_self_modulate
	transition_type = default_transition_type
	ease_type = default_ease_type

func smoothly_change_scheme_to(index: int, duration : float, delay := .0):
	if index >= len(_modulate_schemes) or index < 0:
		return
	
	_twn.stop_all()
	
	for target in _targets:
		if target is CanvasItem:
			_twn.interpolate_property(
				target, 
				"modulate" if not use_self_modulate else "self_modulate", 
				target.modulate if not use_self_modulate else target.self_modulate, 
				_modulate_schemes[index],
				duration,
				transition_type,
				ease_type,
				delay
			)
	
	_twn.start()

