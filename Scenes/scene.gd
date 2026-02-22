extends Node
class_name BaseScene

@export var next_scene: PackedScene
@export var interaction_count = 0
var interactions = 0
var scene_path: String
var loaded_scene: PackedScene

const FAILED = 0
const LOADED = 1
const LOADING = 2
var state = LOADING
var next_scene_loaded = 0

var want_scene = false

func _ready():
	if next_scene != null:
		scene_path = next_scene.resource_path
		ResourceLoader.load_threaded_request(scene_path)
		state = LOADING
	else:
		state = FAILED
	

func _process(_delta):
	while state == LOADING:
		var status = ResourceLoader.load_threaded_get_status(scene_path)

		if status == ResourceLoader.THREAD_LOAD_LOADED:
			loaded_scene = ResourceLoader.load_threaded_get(scene_path)
			print("Scene finished loading!")
			state = LOADED
			change_scene()

		elif status == ResourceLoader.THREAD_LOAD_FAILED:
			push_error("Failed to load scene/empty scene")
			state = FAILED

func change_scene():
	if state == LOADED and want_scene and interactions >= interaction_count:
		get_tree().change_scene_to_packed(loaded_scene)
	elif state == LOADING:
		print("Scene still loading")

func request_change_scene():
	want_scene = true
	change_scene()

func interaction_done_notify() -> bool:
	interactions += 1
	return interactions >= interaction_count
