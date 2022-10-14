tool
extends AspectRatioContainer

### VARIABLES ###
var zoom_stack_index : int 
var follow_node_stack_index : int

var active := false setget set_is_active

### FUNCTIONS ###
# --- Publics ---
func set_is_active(value: bool):
	var camera = Camera2dUtility.get_current_camera(get_viewport())
	
	if active == value or not camera is StatefulCamera2D:
		return
	
	if value:
		var new_zoom = $ReferenceRect.rect_size / get_viewport_rect().size
		
		zoom_stack_index = camera.zoom_stack.get_top_level() + 1
		follow_node_stack_index = camera.follow_node_stack.get_top_level() + 1
		
		camera.zoom_stack.get_array(zoom_stack_index).append(new_zoom)
		camera.follow_node_stack.get_array(follow_node_stack_index).append($Position)
	else:
		camera.zoom_stack.erase_array(zoom_stack_index)
		camera.follow_node_stack.erase_array(follow_node_stack_index)
	
	camera.update_follow_node_from_stack()
	camera.update_zoom_from_stack()
	
	active = value

# --- Privates ---
func _notification(what):
	match what:
		NOTIFICATION_RESIZED, NOTIFICATION_ENTER_TREE: # on transform changes
			$Position.position = rect_size/2 
			ratio = get_viewport().size.x / get_viewport().size.y
			property_list_changed_notify()

func _set_is_active_area2d_wrapper(_body, value: bool):
	set_is_active(value)
