extends Interactable_Disappearing
class_name InteractableSceneChange

var can_change : bool = false

func hover():
    if can_change == false:
        return
    super.hover()
