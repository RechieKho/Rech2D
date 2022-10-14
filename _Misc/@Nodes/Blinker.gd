extends Tween

class_name Blinker

### VARIABLE ###
var _tween_count_left := 0
var _duration_per_tween := 0.0
var _original_modulate: Color
var _changed_modulate: Color
var _target: CanvasItem

var _is_original_modulate := true

### FUNCTION ###
# --- Publics ---
func blink(target: CanvasItem, count: int, duration: float, changed_modulate := Color.black):
	if _target:
		stop_all()
		_target.modulate = _original_modulate
	
	_tween_count_left = count * 2
	_duration_per_tween = duration / (count * 2)
	_original_modulate = target.modulate
	_changed_modulate = changed_modulate
	_target = target
	
	_start_tweening_cycle()


# --- Privates ---

func _ready():
	connect("tween_all_completed", self, "_start_tweening_cycle")

func _start_tweening_cycle():
	if not _tween_count_left:
		_target.modulate = _original_modulate
		_is_original_modulate = true
		_target = null
		return
	
	_tween_modulate(
		_target,
		_original_modulate if not _is_original_modulate else _changed_modulate,
		_duration_per_tween
	)
	_is_original_modulate = not _is_original_modulate
	_tween_count_left -= 1

func _tween_modulate(target: CanvasItem, new_modulate: Color, tween_duration: float):
	interpolate_property(
		target, 
		"modulate", 
		target.modulate,
		new_modulate,
		tween_duration,
		Env.TWEEN_TRANSITION_TYPE,
		Env.TWEEN_EASE_TYPE
	)
	start()
