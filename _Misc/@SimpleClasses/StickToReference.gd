extends Reference

class_name StickToReference

### VARIABLES ###
export var reference_paths = []

var refs_dict : Dictionary

var tween: Tween
var target: Control

### FUNCTIONS ###

# --- Public ---
func stick_to(ref_name: String, duration := .5):
	if not (ref_name in refs_dict.keys()):
		return
	
	_tween_gui_positioning_from(refs_dict[ref_name], duration)

# --- Private ---
func _init(target_control: Control, list_of_refs: Array, tween_node: Tween):
	target = target_control
	refs_dict = _translate_refs_to_dict(list_of_refs)
	tween = tween_node

# get dictionary of ReferenceRect node from array of ReferenceRect node
func _translate_refs_to_dict(refs) -> Dictionary:
	var rs = {}
	for ref in refs:
		assert(ref is ReferenceRect, "Some elements is not ReferenceRect...")
		rs[ref.name] = ref
	return rs

func _tween_gui_positioning_from(control: Control, duration):
	tween.stop_all()
	tween.interpolate_property(
		target, "anchor_bottom",
		target.anchor_bottom,
		control.anchor_bottom,
		duration,
		Env.TWEEN_TRANSITION_TYPE,
		Env.TWEEN_EASE_TYPE
	)
	tween.interpolate_property(
		target, "anchor_left",
		target.anchor_left,
		control.anchor_left,
		duration,
		Env.TWEEN_TRANSITION_TYPE,
		Env.TWEEN_EASE_TYPE
	)
	tween.interpolate_property(
		target, "anchor_right",
		target.anchor_right,
		control.anchor_right,
		duration,
		Env.TWEEN_TRANSITION_TYPE,
		Env.TWEEN_EASE_TYPE
	)
	tween.interpolate_property(
		target, "anchor_top",
		target.anchor_top,
		control.anchor_top,
		duration,
		Env.TWEEN_TRANSITION_TYPE,
		Env.TWEEN_EASE_TYPE
	)
	
	tween.interpolate_property(
		target, "margin_bottom",
		target.margin_bottom,
		control.margin_bottom,
		duration,
		Env.TWEEN_TRANSITION_TYPE,
		Env.TWEEN_EASE_TYPE
	)
	tween.interpolate_property(
		target, "margin_left",
		target.margin_left,
		control.margin_left,
		duration,
		Env.TWEEN_TRANSITION_TYPE,
		Env.TWEEN_EASE_TYPE
	)
	tween.interpolate_property(
		target, "margin_right",
		target.margin_right,
		control.margin_right,
		duration,
		Env.TWEEN_TRANSITION_TYPE,
		Env.TWEEN_EASE_TYPE
	)
	tween.interpolate_property(
		target, "margin_top",
		target.margin_top,
		control.margin_top,
		duration,
		Env.TWEEN_TRANSITION_TYPE,
		Env.TWEEN_EASE_TYPE
	)
	
	tween.start()
#
#func _input(event):
#	if event is InputEventKey and event.is_pressed():
#		if event.scancode == KEY_J:
#			stick_to("ReferenceRect")
#		elif event.scancode == KEY_K:
#			stick_to("ReferenceRect2")
#		elif event.scancode == KEY_L:
#			stick_to("ReferenceRect3")
