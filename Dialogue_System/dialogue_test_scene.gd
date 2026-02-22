extends Control

@export var dg : Dialogue

func _ready():
    var ui : UI = get_node("Ui")
    ui.start(dg)

