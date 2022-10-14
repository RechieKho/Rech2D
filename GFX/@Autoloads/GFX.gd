extends Node


### VARIABLES ###

var blur_gfxes
var circle_gfxes
var distortion_gfxes
var shockwaves_gfx

var _shaker: ShakeOffset

### FUNCTIONS ###
# --- Publics ---
func shake_current_camera(
	viewport: Node, 
	duration = 0.1,
	displacement_multiplier = Vector2(10, 10), 
	rotation_multiplier = 0
	):
	if not _shaker:
		# setup shaker
		_shaker = ShakeOffset.new()
		add_child(_shaker)
		_shaker.process_mode = ShakeOffset.ProcessMode.PHYSICS
	_shaker.damping = 0
	_shaker.target = Camera2dUtility.get_current_camera(viewport)
	_shaker.displacement_multiplier = displacement_multiplier
	_shaker.rotation_multiplier = rotation_multiplier
	yield(get_tree().create_timer(duration), "timeout")
	_shaker.damping = 0.5

# --- Privates ---
func _ready():
	var canvas = CanvasLayer.new()
	add_child(canvas)
	blur_gfxes = GFXES.new(canvas, preload("../@Scenes/Blur/Blur.tscn"))
	circle_gfxes = GFXES.new(canvas, preload("../@Scenes/Circle/Circle.tscn"))
	distortion_gfxes = GFXES.new(canvas, preload("../@Scenes/Distortion/Distortion.tscn"))
	
	shockwaves_gfx = preload("../@Scenes/Shockwaves/Shockwaves.tscn").instance()
	canvas.add_child(shockwaves_gfx)

### SUBCLASSES ###
class GFXES:
	var _canvas :CanvasLayer
	var _gfx_resource
	var _gfxes = {}
	
	func _init(canvas: CanvasLayer, gfx_resource):
		_canvas = canvas
		_gfx_resource = gfx_resource
	
	func create_gfx(key: String):
		if key in _gfxes.keys():
			return
		var new_gfx = _gfx_resource.instance()
		_gfxes[key] = new_gfx
		_canvas.add_child(new_gfx)
	
	func remove_gfx(key: String):
		var gfx = _gfxes.get(key)
		if gfx == null:
			return 
		_gfxes.erase(key)
		_canvas.remove_child(gfx)
		gfx.queue_free()
	
	func get_gfx(key: String):
		create_gfx(key)
		return _gfxes[key]
