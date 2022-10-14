extends Node

"""Apply value to the property."""

class_name SyncProperty

### VARIABLES ###

export var property_name: String
export(Array, NodePath) var target_node_paths = []
export var _reload_nodes : bool setget _reload

onready var nodes := _get_nodes(target_node_paths)

### FUNCTIONS ###

func set_property_value(new_value):
	for node in nodes:
		node.set(property_name, new_value)

func _get_nodes(paths: Array) -> Array:
	var ls = []
	for path in paths:
		ls.append(get_node(path))
	return ls

func _reload(_value):
	nodes = _get_nodes(target_node_paths)
