extends OffsetNode

"""Shake node through offset"""

class_name ShakeOffset

enum ProcessMode {
	IDLE,
	PHYSICS
}

### VARIABLE ###
export var default_target_path: NodePath
export(ProcessMode) var process_mode = ProcessMode.IDLE

var target setget set_target
var displacement_multiplier: Vector2 = Vector2.ZERO
var rotation_multiplier: float = 0
var damping: float = 1 setget set_damping 
# 1 means no damp while 0 means extreme damp for internal work
# The value got reversed by the setter function so that it makes more sense
var target_offset_origin: Vector2
var target_rotation_origin: float

### SETGET ###
func set_target(node: Node2D):
	if is_shakable(node):
		target = node
		target_rotation_origin = target.rotation_degrees
		target_offset_origin = target.offset

func set_damping(value: float):
	damping = 1 - clamp(value, 0, 1)

### FUNCTION ###
# --- Publics ---

func is_shakable(node: Node2D):
	return node.get("offset") != null and node.get("rotation_degrees") != null

# --- Privates ---

func _ready():
	var default_target = get_node_or_null(default_target_path)
	set_target(default_target if default_target and is_shakable(default_target) else self)
	

func _process(_delta):
	if process_mode == ProcessMode.IDLE:
		_shake()

func _physics_process(_delta):
	if process_mode == ProcessMode.PHYSICS:
		_shake()

func _shake():
	if target == null:
		return
	
	var rand_disp = _generate_random_displacement(displacement_multiplier)
	target.offset = rand_disp + target_offset_origin
	var rand_rot = _generate_random_rotation(rotation_multiplier)
	target.rotation_degrees = rand_rot + target_rotation_origin
	
	# damping
	displacement_multiplier *= damping 
	rotation_multiplier *= damping 

func _generate_random_displacement(multiplier: Vector2) -> Vector2:
	return Vector2(
		rand_range(-1, 1),
		rand_range(-1, 1)
	).normalized() * multiplier

func _generate_random_rotation(multiplier: float) -> float:
	return rand_range(-1, 1) * multiplier
