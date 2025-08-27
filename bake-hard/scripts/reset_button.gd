extends Button

func _pressed():
    print("resetting scene")
    var current_scene = get_tree().current_scene
    if current_scene:
        get_tree().reload_current_scene()
    else:
        print("Error: current_scene is null")
