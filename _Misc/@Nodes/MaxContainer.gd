tool
extends Container

"""A container that limits child control size."""

class_name MaxContainer

### VARIABLE ###

export var max_size = Vector2(500, -1) setget set_max_size

func set_max_size(value: Vector2):
	max_size = value
	_resize_children()


func _notification(what):
	match what:
		NOTIFICATION_RESIZED:
			_resize_children()

func _resize_children():
	for c in get_children():
		var child_rect_size = Vector2(
			min(rect_size.x, max_size.x) if max_size.x >= 0 else rect_size.x,
			min(rect_size.y, max_size.y) if max_size.y >= 0 else rect_size.y
		)
		fit_child_in_rect(
			c,
			Rect2(
				rect_size / 2 - child_rect_size / 2,
				child_rect_size
			)
		)
