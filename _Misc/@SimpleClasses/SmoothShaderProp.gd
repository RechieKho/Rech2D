extends Reference

class_name SmoothShaderProp

var _twn: Tween
var _shader_param: ShaderParam

func _init(twn: Tween, shader: ShaderMaterial, param: String):
	_twn = twn
	_shader_param = ShaderParam.new(shader, param)

func smoothly_change_to(new_value, duration: float, delay=0):
	_twn.stop_all()
	_twn.interpolate_property(
		_shader_param,
		"prop",
		_shader_param.prop,
		new_value,
		duration,
		Env.TWEEN_TRANSITION_TYPE,
		Env.TWEEN_EASE_TYPE,
		delay
	)
	_twn.start()

### SUBCLASS ###
class ShaderParam:
	
	var _shader: ShaderMaterial
	var _param: String
	var prop setget set_prop, get_prop
	
	func _init(shader: ShaderMaterial, param: String):
		_shader = shader
		_param = param
	
	func set_prop(value):
		_shader.set_shader_param(_param, value)
	
	func get_prop():
		return _shader.get_shader_param(_param)
