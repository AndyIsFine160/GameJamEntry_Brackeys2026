extends Resource
class_name Dialogue
# class Dialogue:

var name: String
var text: String
@export var index: int
signal dialogue_finished

@export var content: Array[Pair]

func next():
    index += 1
    if index >= len(content):
        dialogue_finished.emit()
        index = 0
        return

    name = content[index].name
    text = content[index].text


    