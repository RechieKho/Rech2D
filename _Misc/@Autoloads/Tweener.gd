extends Node

"""Autoload that allows tween without adding node."""

### VARIABLE ###

var _tweens = {}

### FUNCTIONS ###
# --- Public ---

func create_tween(key: String):
	if key in _tweens.keys():
		return
	var new_tween = Tween.new()
	_tweens[key] = new_tween
	add_child(new_tween)

func remove_tween(key: String):
	var tween = _tweens.get(key)
	if tween == null:
		return 
	_tweens.erase(key)
	remove_child(tween)
	tween.queue_free()

func clean_tween():
	for tween_name in _tweens.keys():
		if !_tweens[tween_name].is_active():
			remove_tween(tween_name)

func get_tween(key: String) -> Tween:
	create_tween(key)
	return _tweens[key]
