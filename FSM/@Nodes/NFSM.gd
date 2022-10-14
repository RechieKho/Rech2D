extends Reference

"""Node-based Finite State Machine
Each node is considered a state. Active state (current state)'s processes 
(including _process, _physics_process, _input and etc.) will be active while
the other state's processes will be inactive. 

State's `_enter_state` function will be called when state started while
state's `_exit_state` function will be called when state exited.
"""

class_name NFSM

### SIGNAL ###
signal on_state_changed(new_current_state)

### VARIABLE ###

var state_stack : ArrayTower

var current_state setget change_state_to
var _state_map : Dictionary = {} # { "STATE_KEY": Node }
var active: bool = true setget set_active

### SETGET ###

func set_active(value: bool):
	if active == value:
		return
	_set_state_activity(_state_map[current_state], value)
	active = value

### FUNCTION ###
# --- Public ---

func _init():
	state_stack = ArrayTower.new()

func register_state(node: State, context):
	_state_map[node.name] = node
	node.context = context

func get_states() -> Array:
	return _state_map.values()

func change_state_to(state_id: String):
	state_stack.top_value = state_id
	update_current_state_from_stack()

func update_current_state_from_stack():
	if not active:
		return
	var new_current_state = state_stack.top_value
	if new_current_state != current_state:
		# _state_history and current_state is out of sync, change current_state
		if _is_state_id_valid(new_current_state):
			_state_map[new_current_state]._enter_state(current_state)
			_set_state_activity(_state_map[new_current_state], true) # new state to active
		
		if _is_state_id_valid(current_state):
			_state_map[current_state]._exit_state(new_current_state)
			_set_state_activity(_state_map[current_state], false) # old state to inactive
		emit_signal("on_state_changed", new_current_state)
		current_state = new_current_state # update current state
		

# --- Private ---

func _is_state_id_valid(state_id) -> bool:
	if state_id == null:
		return false
	return state_id in _state_map.keys()

func _set_state_activity(node, is_active: bool):
	node.set_physics_process(is_active)
	node.set_process(is_active)
	node.set_process_input(is_active)
	node.set_process_unhandled_input(is_active)
	node.set_process_unhandled_key_input(is_active)
