extends Node3D
class_name Interactable

var hovered : bool = false
@export var dialogue : Dialogue
@onready var shader : ShaderMaterial = $Mesh.get_surface_override_material(0).next_pass


func hover():
	if hovered:
		return
	hovered = true
	shader.set_shader_parameter("strength", 0.7)

func unhover():
	if !hovered:
		return
	hovered = false
	shader.set_shader_parameter("strength", 0.0)
