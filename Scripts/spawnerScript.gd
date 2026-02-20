extends Node3D

# Drag spawnable scenes here
@export var items: Array[PackedScene]

# Adjustable spawn area (box range)
@export var min_spawn_range: Vector3 = Vector3(-5, 0, -5)
@export var max_spawn_range: Vector3 = Vector3(5, 5, 5)

# Uniform scale range (single float)
@export var min_scale: float = 0.5
@export var max_scale: float = 2.0

@export var spawn_count: int = 10
@export var random_rotation: bool = true

func _ready():
	randomize()
	spawn_items()

func spawn_items():
	if items.is_empty():
		return

	for i in spawn_count:
		var scene = items.pick_random()
		var instance = scene.instantiate()
		add_child(instance)

		# 🎯 Random Position
		instance.position = Vector3(
			randf_range(min_spawn_range.x, max_spawn_range.x),
			randf_range(min_spawn_range.y, max_spawn_range.y),
			randf_range(min_spawn_range.z, max_spawn_range.z)
		)

		# 🔄 Random Rotation
		if random_rotation:
			instance.rotation_degrees = Vector3(
				randf_range(0, 360),
				randf_range(0, 360),
				randf_range(0, 360)
			)

		# 📏 Uniform Scale (keeps proportions)
		var s = randf_range(min_scale, max_scale)
		instance.scale = Vector3.ONE * s
