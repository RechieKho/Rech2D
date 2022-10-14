extends Area2D

"""Store and manipulate health."""

class_name Health

### SIGNAL ###
signal on_health_changed(new_health)
signal on_damage_taken(new_health, damage_info)
signal on_healed(new_health)

### VARIABLE ###
export var max_health : int = 10 setget set_max_health

var current_health: int setget set_current_health
var invincible := false

### SETGET ###

func set_current_health(value:int) -> void:
	current_health = clamp(value, 0, max_health)
	emit_signal("on_health_changed", value)

func set_max_health(value: int) -> void:
	if value <= 0:
		return
	max_health = value
	set_current_health(current_health) # so current_health won't exceed max_health

### FUNCTION ###
# --- Public ---

func make_invincible():
	invincible = true

func make_vulnerable():
	invincible = false

func is_dead() -> bool:
	return current_health == 0

func take_damage(damage_info: DamageInfo)->int:
	if current_health == 0 or invincible:
		return current_health
	set_current_health(current_health - damage_info.amount)
	emit_signal("on_damage_taken", current_health, damage_info)
	return current_health

# Heal for certain amount only when not max health.
func heal(amount:int) -> int:
	if current_health == max_health:
		return current_health
	set_current_health(current_health + amount)
	emit_signal("on_healed", current_health)
	return current_health

# Heal until max health only when not max health.
func complete_heal() -> int:
	if current_health == max_health:
		return current_health
	set_current_health(max_health)
	emit_signal("on_healed", current_health)
	return current_health

# --- Private ---
func _ready():
	current_health = max_health
