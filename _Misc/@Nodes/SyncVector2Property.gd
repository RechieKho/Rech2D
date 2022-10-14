tool
extends SyncProperty

### VARIABLES ###
export var value : Vector2 setget set_property_value

### FUNCTIONS ###
func set_property_value(new_value):
	.set_property_value(new_value)
	value = new_value
