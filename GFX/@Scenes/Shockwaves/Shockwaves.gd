extends Node

### VARIABLES ###

var _shockwaves = [] # stores instances of Shockwave

### FUNCTIONS ###
func play_shockwave(
	position: Vector2,
	distortion_size: float, 
	duration := 0.7 ,
	distortion_force := 0.1, 
	distortion_thickness := .05
	):
	for shockwave in _shockwaves:
		if not shockwave.is_playing():
			shockwave.play(position, distortion_size, duration, distortion_force, distortion_thickness)
			return
	
	var new_shockwave = Shockwave.new($Distortions, get_node("/root"))
	new_shockwave.play(position, distortion_size, duration, distortion_force, distortion_thickness)
	_shockwaves.append(new_shockwave)


### SUBCLASSES ###
class Shockwave:
	
	var distortion
	var position_node : Position2D
	
	var _distortion_resource = preload("../Distortion/Distortion.tscn")
	var _is_playing: bool
	
	func _init(distortion_parent: Node, position_node_parent: Node):
		position_node = Position2D.new()
		position_node_parent.add_child(position_node)
		distortion = _distortion_resource.instance()
		distortion.distortion_follow_node = position_node
		distortion_parent.add_child(distortion)
		
		distortion.smooth_distortion_size._twn.connect("tween_all_completed", self, "_on_distortion_end")
	
	func play(
		global_position: Vector2, 
		distortion_size: float,
		duration,
		distortion_force,
		distortion_thickness
	):
		if _is_playing:
			return
		
		position_node.global_position = global_position
		
		distortion.is_following = true
		distortion.effect.material.set_shader_param("distortion_force", distortion_force)
		distortion.effect.material.set_shader_param("distortion_thickness", distortion_thickness)
		distortion.effect.material.set_shader_param("distortion_size", 0)
		distortion.smooth_distortion_force.smoothly_change_to(0, duration)
		distortion.smooth_distortion_thickness.smoothly_change_to(0, duration)
		distortion.smooth_distortion_size.smoothly_change_to(distortion_size, duration)
		
		_is_playing = true
	
	func is_playing():
		return _is_playing
	
	func _on_distortion_end():
		distortion.is_following = false
		_is_playing = false
