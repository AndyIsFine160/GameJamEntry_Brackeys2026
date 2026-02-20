extends Node

var camera : Camera3D
var ray : RayCast3D
var previous
@export var length = 1

func _ready():
	ray = get_node("RayCast3D")

func _process(delta : float):
	camera = get_viewport().get_camera_3d()
	if camera != null:
		ray.global_position = camera.global_position
		var basis = Basis.from_euler(camera.global_rotation)
		var forward = -basis.z
		ray.target_position = forward * length

		if ray.is_colliding():
			get_node("Target").global_position = ray.get_collision_point()
			var area = ray.get_collider() as Node
			var tg = area.get_parent()
			if tg is Interactable:
				tg.hover()
				previous = tg
		else:
			get_node("Target").global_position = ray.to_global(ray.target_position)
			if previous != null:
				previous.unhover()
				previous = null
