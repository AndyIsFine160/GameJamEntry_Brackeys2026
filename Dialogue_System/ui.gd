extends Control
class_name UI
@export var dialogue : Dialogue

func say() -> void:
	if dialogue == null:
		return
	get_node("Panel/Dialogue/Name").text = dialogue.name;
	get_node("Panel/Dialogue/Text").text = dialogue.text;


func _input(event) -> void:
	if dialogue == null:
		hide()
		return
	if visible:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				dialogue.next()
				say()

func on_dialogue_finished():
	hide()
	dialogue.dialogue_finished.disconnect(on_dialogue_finished)
	dialogue = null

func set_dialogue(dg : Dialogue) -> void:
	dg.dialogue_finished.connect(on_dialogue_finished)
	dialogue = dg
	dg.index = -1
	dialogue.next()
	say()

## Call this to start a dialogue.
## Accepts the custom dialogue resource
func start(dg : Dialogue):
	set_dialogue(dg)
	show()
