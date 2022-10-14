extends Node

"""State Node for Finite State Machine"""

class_name State

var context

func _ready():
	# Deactivate Node. Only activate it when the state is active
	set_physics_process(false)
	set_process(false)
	set_process_input(false)
	set_process_unhandled_input(false)
	set_process_unhandled_key_input(false)

func _enter_state(_previous_state):
	pass

func _exit_state(_next_state):
	pass

