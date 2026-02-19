extends Control
class_name UI
@export var dialogue : Dialogue

func say(dg : Dialogue) -> void:
    get_node("Panel/Dialogue/Name").text = dg.name;
    get_node("Panel/Dialogue/Text").text = dg.text;
    print(dg.name)
    print(dg.text)


func _input(event) -> void:
    if visible:
        if event is InputEventMouseButton:
            if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
                dialogue.next()
                say(dialogue)

func on_dialogue_finished():
    hide()
    pass

func set_dialogue(dg : Dialogue) -> void:
    dg.dialogue_finished.connect(on_dialogue_finished)
    dialogue = dg
    dg.index = -1

## Call this to start a dialogue.
## Accepts the custom dialogue resource
func start(dg : Dialogue):
    set_dialogue(dg)
    show()

