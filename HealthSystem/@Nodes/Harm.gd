extends Area2D

"""Damage bodies with health. """

class_name Harm

### FUNCTION ###
func harm(damage_amount: int):
	var targets = get_overlapping_areas()
	for target in targets:
		target.take_damage(DamageInfo.new(damage_amount, global_position))
