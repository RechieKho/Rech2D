extends Node

var camera_cache = {}

### FUNCTION ###
# --- Publics ---
func get_current_camera(viewport: Node) -> Camera2D:
	var camera_from_cache = camera_cache.get(viewport.get_instance_id())
	if camera_from_cache:
		return camera_from_cache
	
	# A way to make this shit faster, just put the camera at the top of the scene
	for child in viewport.get_children():
		if child is Camera2D and child.current:
			camera_cache[viewport.get_instance_id()] = child # caching
			return child
		
		var camera = get_current_camera(child)
		if camera:
			camera_cache[viewport.get_instance_id()] = camera # caching
			return camera
		
	return null

# As long as the current camera is changed, clear_camera_cache 
# or erase_camera_cache need to be called
func erase_camera_cache(viewport: Node):
	camera_cache.erase(viewport.get_instance_id())

func clear_camera_cache():
	camera_cache.clear()


