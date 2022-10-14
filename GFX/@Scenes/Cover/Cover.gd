extends ColorRect

### VARIABLES ###
export var tween_duration := 0.7

onready var darkened_color = color
onready var smooth_color = SmoothProp.new(
	$Tween, self, "color"
)

### FUNCTIONS ###
# --- Publics ---
func smoothly_darken():
	smooth_color.smoothly_change_to(darkened_color, tween_duration)

func smoothly_hidden():
	smooth_color.smoothly_change_to(Color.transparent, tween_duration)

# --- Privates ---
func _ready():
	color = Color.transparent
