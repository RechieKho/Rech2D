extends Control

### ENUM ###
enum ProcessMode {
	IDLE,
	PHYSICS
}

### VARIABLES ###
onready var effect = $Effect
onready var smooth_circle_size := SmoothShaderProp.new(
	$Tweens/Size, effect.material, "circle_size"
)
onready var smooth_circle_scatter_intensity := SmoothShaderProp.new(
	$Tweens/ScatterIntensity, effect.material, "circle_scatter_intensity"
)


onready var circle_size_stack := ArrayTower.new()
onready var circle_scatter_intensity_stack := ArrayTower.new()

var circle_center setget set_circle_center, get_circle_center
var circle_follow_node: Node2D
var process_mode = ProcessMode.IDLE setget set_process_mode
var is_following := false setget set_is_following

### FUNCTIONS ###
# --- Publics ---
func set_process_mode(value):
	if process_mode == value:
		return
	
	if is_following:
		set_process(value == ProcessMode.IDLE)
		set_physics_process(value == ProcessMode.PHYSICS)
	
	process_mode = value

func set_is_following(value: bool):
	if is_following == value:
		return
	
	set_process(value if process_mode == ProcessMode.IDLE else false)
	set_physics_process(value if process_mode == ProcessMode.PHYSICS else false)
	
	is_following = value

func set_circle_center(value: Vector2):
	effect.material.set_shader_param("circle_center", value)

func get_circle_center():
	effect.material.get_shader_param("circle_center")

func update_circle_size_from_stack(tween_duration := 1):
	var new_circle_size = circle_size_stack.top_value
	if new_circle_size != null and new_circle_size != effect.material.get_shader_param("circle_size"):
		# circle_size_stack and current circle size is out of sync, change circle size
		smooth_circle_size.smoothly_change_to(new_circle_size, tween_duration)

func update_circle_scatter_intensity_from_stack(tween_duration := 1):
	var new_circle_scatter_intensity = circle_scatter_intensity_stack.top_value
	if new_circle_scatter_intensity != null and new_circle_scatter_intensity != effect.material.get_shader_param("circle_scatter_intensity"):
		# circle_scatter_intensity_stack and current circle scatter intensity is out of sync,
		# change circle scatter intensity
		smooth_circle_scatter_intensity.smoothly_change_to(new_circle_scatter_intensity, tween_duration)


# --- Privates ---
func _ready():
	set_process(false)
	set_physics_process(false)

func _process(_delta):
	_update_follow_node()

func _physics_process(_delta):
	_update_follow_node()

func _update_follow_node():
	if circle_follow_node:
		var screen_pos = _get_screen_position(circle_follow_node)
		set_circle_center(screen_pos)

func _get_screen_position(node: Node2D):
	var screen_pos = node.get_global_transform_with_canvas().get_origin() / get_viewport_rect().size
	screen_pos.y = 1 - screen_pos.y
	return screen_pos
