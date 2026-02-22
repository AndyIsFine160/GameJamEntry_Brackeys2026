extends Area3D
class_name DialogueArea

@export var dialogue : Dialogue
signal player_entered

func _ready():
	body_entered.connect(player_detected)

func player_detected(_body):
	print("player detected")
	player_entered.emit(dialogue, self)
