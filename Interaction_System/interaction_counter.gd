extends Control
class_name InteractionCounter

@onready var count : Label = $HBoxContainer/Count
@onready var total : Label = $HBoxContainer/Total

func set_interaction_count(a, b):
	count.text = str(a)
	total.text = str(b)
