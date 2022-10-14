extends Camera2D

"""Extends the functionality of Camera2D"""

class_name SmoothCamera2D

### VARIABLE ###

export var default_follow_node: NodePath

var follow_node : Node2D = null setget set_follow_node

var smooth_zoom := SmoothProp.new(
	Tweener.get_tween("SmoothCamera2D/zoom"), self, "zoom"
)
var smooth_offset := SmoothProp.new(
	Tweener.get_tween("SmoothCamera2D/offset"), self, "offset"
)

### SETGET ###
func set_follow_node(node: Node2D):
	get_parent().call_deferred("remove_child", self)
	if node:
		node.call_deferred("add_child", self)
		position = Vector2.ZERO
	else:
		get_tree().root.call_deferred("add_child", self)
	follow_node = node

### FUNCTIONS ###
# --- Private ---

func _ready():
	if default_follow_node:
		set_follow_node(get_node(default_follow_node))
	set_enable_follow_smoothing(true)
