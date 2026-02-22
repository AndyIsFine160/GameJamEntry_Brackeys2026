extends Node3D

var base_degrees_per_second: float
var time_scale: float

func _ready():
	base_degrees_per_second = randf_range(4.0, 10.0)
	time_scale = randf_range(1.0, 80.0)

func _process(delta):
	var final_speed = base_degrees_per_second * time_scale
	rotate_z(deg_to_rad(final_speed * delta))
