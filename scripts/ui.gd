extends Control


@export var pause_menue : Control
@export var option_menue : Control

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause") :
		var visiblee = pause_menue.visible
		if not visiblee :
			pause_menue.visible = true
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
			get_tree().paused = true
		if visiblee :
			pause_menue.visible = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			get_tree().paused = false


func _on_continue_pressed() -> void:
	pause_menue.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_option_pressed() -> void:
	option_menue.visible = true


func _on_button_pressed() -> void:
	option_menue.visible = false
