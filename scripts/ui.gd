extends Control


@export var pause_menue : Control

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause") :
		var visible = pause_menue.visible
		if not visible :
			pause_menue.visible = true
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
			get_tree().paused = true
		if visible :
			pause_menue.visible = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			get_tree().paused = false


func _on_continue_pressed() -> void:
	pause_menue.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false


func _on_quit_pressed() -> void:
	get_tree().quit()
