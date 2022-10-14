extends SmoothCamera2D

class_name StatefulCamera2D

### VARIABLE ###
export var tween_duration := .7

var zoom_stack := ArrayTower.new()
var offset_stack := ArrayTower.new()
var follow_node_stack := ArrayTower.new()

### FUNCTION ###
# --- Publics ---
func update_zoom_from_stack():
	var new_zoom = zoom_stack.top_value
	if new_zoom != null and new_zoom != zoom:
		smooth_zoom.smoothly_change_to(new_zoom, tween_duration)

func update_offset_from_stack():
	var new_offset = offset_stack.top_value
	if new_offset != null and new_offset != zoom:
		smooth_offset.smoothly_change_to(new_offset, tween_duration)

func update_follow_node_from_stack():
	var new_follow_node = follow_node_stack.top_value
	if new_follow_node != null and new_follow_node != follow_node:
		set_follow_node(new_follow_node)

# --- Privates ---
func _ready():
	zoom_stack.top_value = zoom
	offset_stack.top_value = offset
	follow_node_stack.top_value = follow_node
