extends Node3D

@export var base_degrees_per_second: float = 6.0   # Normal speed (like real seconds)
@export var time_scale: float = 1.0                # Speed multiplier

func _process(delta):
	var final_speed = base_degrees_per_second * time_scale
	rotate_z(deg_to_rad(final_speed * delta))
