extends AudioStreamPlayer
"""An Autoload that manages background music"""

### VARIABLE ###

onready var smooth_volume_db = SmoothProp.new(
	Tweener.get_tween("bgm_transition_volume"), self, "volume_db"
)
onready var volume_db_stack := ArrayTower.new()
onready var music_stack := ArrayTower.new()
var current_music: AudioStream = null setget set_current_music

### FUNCTION ###
# --- Public ---

func set_current_music(resource, duration := 0.0):
	if current_music == resource:
		return
	music_stack.top_value = resource
	update_music_from_stack(duration)

func smoothly_change_music(resource: AudioStream, duration: float):
	if duration == 0:
		stream = resource
		current_music = resource
		play()
	else:
		var tween_duration = duration / 2
		smooth_volume_db.smoothly_change_to(-80, tween_duration)
		yield(smooth_volume_db._twn, "tween_all_completed")
		stream = resource
		current_music = resource
		play()
		update_volume_db_from_stack(tween_duration)

# duration and not tween duration because it is the total duration
func update_music_from_stack(duration := 0.0): 
	var new_current_music = music_stack.top_value
	if new_current_music and new_current_music != current_music:
		# music_stack and current_music is out of sync, change current_music
		smoothly_change_music(new_current_music, duration)

func update_volume_db_from_stack(tween_duration: float):
	var new_volume_db = volume_db_stack.top_value
	if new_volume_db != volume_db:
		# volume_db_stack and volume_db is out of sync, change volume_db
		smooth_volume_db.smoothly_change_to(new_volume_db if new_volume_db else 0, tween_duration)

# --- Private ---

func _ready():
	bus = "BGM"
	pause_mode = Node.PAUSE_MODE_PROCESS


