extends Node

"""Autoload allows timer without adding node."""

### VARIABLE ###

var _timers = {}

### FUNCTIONS ###
# --- Public ---

func create_timer(name: String):
	if name in _timers.keys():
		return
	var new_timer = Timer.new()
	_timers[name] = new_timer
	add_child(new_timer)

func remove_timer(name: String):
	var timer = _timers.get(name)
	if timer == null:
		return 
	_timers.erase(name)
	remove_child(timer)
	timer.queue_free()

func clean_timer():
	for timer_name in _timers.keys():
		if !_timers[timer_name].is_active():
			remove_timer(timer_name)

func has_timer(name: String) -> bool:
	return name in _timers.keys()

func get_timer(name: String) -> Timer:
	create_timer(name)
	return _timers[name]

func plan(
	delay_duration: float, 
	object: Object, 
	funcname: String, 
	args = []
	) -> int:
	var queue_hash := hash([object, funcname, args])
	var timer = get_timer(str(queue_hash))
	timer.wait_time = delay_duration
	timer.one_shot = true
	timer.connect("timeout", object, funcname, args)
	timer.connect("timeout", self, "remove_timer", [str(queue_hash)])
	timer.start()
	return queue_hash

func destroy_plan(queue_hash: int):
	if not has_timer(str(queue_hash)):
		return
	
	get_timer(str(queue_hash)).stop()
	remove_timer(str(queue_hash))
