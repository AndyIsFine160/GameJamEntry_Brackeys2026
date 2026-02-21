extends Node

var camera : Camera3D
var player : CharacterBody3D
var ray : RayCast3D
var current : Interactable
@export var length = 1

@onready var ui : UI = $UI

func _ready():
	ray = get_node("RayCast3D")
	ui.hidden.connect(ui_hidden)

func _process(delta : float):
	camera = get_viewport().get_camera_3d()
	if camera != null:
		player = camera.get_parent().get_parent()
		ray.global_position = camera.global_position
		var basis = Basis.from_euler(camera.global_rotation)
		var forward = -basis.z
		ray.target_position = forward * length

		if ray.is_colliding():
			# get_node("Target").global_position = ray.get_collision_point()
			var area = ray.get_collider() as Node
			var tg = area.get_parent()
			if tg is Interactable:
				if current == null:
					player.interact_signal.connect(interact)
				tg.hover()
				current = tg
		else:
			# get_node("Target").global_position = ray.to_global(ray.target_position)
			if current != null:
				current.unhover()
				player.interact_signal.disconnect(interact)
				current = null

func interact():
	ui.start(current.dialogue)
	player.set_physics_process(false)

func ui_hidden():
	player.set_physics_process(true)
