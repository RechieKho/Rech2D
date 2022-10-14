extends RigidBody2D

class_name Character2D

### VARIABLE ###

export (NodePath) var floor_detector # `Area2D` node that detects floor.

onready var gravity_scale_disabler := QuantitativeDisabler.new(
	funcref(self, "set_gravity_scale"), funcref(self, "get_gravity_scale")
)
onready var collision_layer_disabler := QuantitativeDisabler.new(
	funcref(self, "set_collision_layer"), funcref(self, "get_collision_layer")
)
onready var collision_mask_disabler := QuantitativeDisabler.new(
	funcref(self, "set_collision_mask"), funcref(self, "get_collision_mask")
)

### FUNCTION ###
# --- Public ---

# Apply impulse without exceeding velocity.
func apply_curbed_central_impulse(
	max_magnitude: float, 
	direction: Vector2,
	velocity: float
) ->void:
	var impulse = _calc_curbed_impulse(max_magnitude, direction, velocity)
	apply_central_impulse(impulse * mass)

# Apply impulse that reduces velocity.
func apply_brake(
	brake_multiplier_X := 1.0,
	brake_multiplier_Y := 1.0
) -> void:
	var impulse := Vector2()
	impulse.x = -linear_velocity.x * brake_multiplier_X
	impulse.y = -linear_velocity.y * brake_multiplier_Y
	apply_central_impulse(impulse * mass)

# Set current velocity to 0.
func clear_velocity(clear_x=true, clear_y=true):
	linear_velocity = Vector2(
		linear_velocity.x * int(not clear_x),
		linear_velocity.y * int(not clear_y)
	)

# Check whether the body is on floor.
func is_on_floor() -> bool:
	# NOTE: this function follows the "Rules for Collision Layer and Mask"
	# please assign all the entity to the correct collision layer and mask
	for body in get_node(floor_detector).get_overlapping_bodies():
		if body.get_collision_layer_bit(Env.CLB_ENV):
			return true
	return false

# --- Private ---

# Calculate impulse for `apply_curbed_impulse`
func _calc_curbed_impulse(max_magnitude: float, direction: Vector2, velocity: float) -> Vector2:
	var normalized_direction = direction.normalized()
	var current_velocity = linear_velocity
	var clean_max_magnitude := clamp(max_magnitude, 0, velocity)
	var impulse := Vector2()
	impulse.x = (-abs((clean_max_magnitude / velocity) * current_velocity.x) + clean_max_magnitude) * normalized_direction.x
	impulse.y = (-abs((clean_max_magnitude / velocity) * current_velocity.y) + clean_max_magnitude) * normalized_direction.y
	return impulse

### SUBCLASS ###
class QuantitativeDisabler:
	# "Disable" property that is quantitative instead of boolean, such as gravity_scale
	var _disable_value
	var _enable_value
	var _setter: FuncRef
	var _getter: FuncRef
	var disabled: bool = false setget set_disabled
	
	func _init(setter: FuncRef, getter: FuncRef, disable_value = 0):
		_disable_value = disable_value
		_setter = setter
		_getter = getter
	
	func set_disabled(is_disabled: bool):
		if is_disabled == disabled:
			return
		
		if is_disabled:
			_enable_value = _getter.call_func()
			_setter.call_func(_disable_value)
		elif _getter.call_func() == _disable_value:
			_setter.call_func(_enable_value)
		
		disabled = is_disabled
