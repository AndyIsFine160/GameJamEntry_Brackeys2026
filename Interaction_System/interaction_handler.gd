extends Node

class_name InteractionHandler

var camera : Camera3D
var player : CharacterBody3D
var ray : RayCast3D
var current : Interactable_Disappearing
var current_area : DialogueArea
var can_change_scene : bool
var interaction_total : int
@export var length = 1

@onready var ui : UI = $UI
@onready var interaction_counter : InteractionCounter = $InteractionCounter

func _ready():
	ray = get_node("RayCast3D")
	ui.hidden.connect(ui_hidden)
	for child in get_children():
		if child is DialogueArea:
			child.player_entered.connect(interact_area)

func _process(_delta : float):
	camera = get_viewport().get_camera_3d()
	if camera != null:
		if player == null:
			player = camera.get_parent().get_parent()
		ray.global_position = camera.global_position
		var basis = Basis.from_euler(camera.global_rotation)
		var forward = -basis.z
		ray.target_position = forward * length

		if ray.is_colliding():
			# get_node("Target").global_position = ray.get_collision_point()
			var area = ray.get_collider() as Node
			var tg = area.get_parent()
			if tg is Interactable_Disappearing:
				if tg.interacted:
					return
				if tg is InteractableSceneChange:
					tg.can_change = can_change_scene
				if current == null:
					player.interact_signal.connect(interact)
				tg.hover()
				current = tg
		else:

			if current != null:
				current.unhover()
				player.interact_signal.disconnect(interact)
				current = null

func interact():
	if current == null:
		return
	if current.interacted:
		return
	
	if current is InteractableSceneChange:
		if current.can_change == false:
			return

	ui.start(current.dialogue)
	player.set_physics_process(false)

func ui_hidden():
	if current != null:
		current.done()
		if current is Interactable_Disappearing:
			var main_scene = get_tree().current_scene
			if main_scene is BaseScene:
				can_change_scene = main_scene.interaction_done_notify()
				interaction_counter.set_interaction_count(main_scene.interactions, main_scene.interaction_count)

		if current is InteractableSceneChange:
			print("success")
			var main_scene = get_tree().current_scene
			if main_scene is BaseScene:
				main_scene.request_change_scene()
	if current_area != null:
		current_area.queue_free()
		current_area = null
				

	player.set_physics_process(true)

func interact_area(dg : Dialogue, area : DialogueArea):
	current_area = area
	player.set_physics_process(false)
	ui.start(dg)

func set_interaction_total(t : int):
	interaction_total = t
	interaction_counter.set_interaction_count(0, t)
	if t == 0:
		can_change_scene = true
