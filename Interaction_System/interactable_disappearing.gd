extends Interactable
class_name Interactable_Disappearing

var interacted = false

func hover():
    if interacted:
        return
    super.hover()

func done():
    interacted = true

