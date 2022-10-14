tool
extends Node2D

"""Node that has offset property.

Please don't set `position` property directly, use position_origin instead.
"""

class_name OffsetNode

### VARIABLE ###

export var offset := Vector2.ZERO setget set_offset
export var position_origin : Vector2 setget set_position_origin


### SETGET ###

func set_offset(value: Vector2):
	offset = value
	position = offset + position_origin

func set_position_origin(value: Vector2):
	position_origin = value
	position = offset + position_origin

func _ready():
	set_notify_local_transform(true)

func _notification(what):
	match what:
		35: # on transform changes
			if (offset + position_origin) != position:
				position_origin = position - offset
				if Engine.editor_hint:
					property_list_changed_notify()
