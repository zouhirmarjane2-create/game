extends Control


@export var pause_menue : Control
@export var shop : Panel
@export var option_menue : Control

func _process(delta: float) -> void:

	if Input.is_action_just_pressed("open shop") and not shop.visible:
		shop.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		get_tree().paused = true
	elif Input.is_action_just_pressed("open shop") and shop.visible:
		shop.visible = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		get_tree().paused = false
	
	if Input.is_action_just_pressed("pause") :
		var p_visiblee = pause_menue.visible
		var s_visiblee = shop.visible
		var o_visible = option_menue.visible
		if s_visiblee : 
			shop.visible = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			get_tree().paused = false
		elif  o_visible : 
			option_menue.visible = false
		elif not p_visiblee :
			pause_menue.visible = true
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
			get_tree().paused = true
		else:
			pause_menue.visible = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			get_tree().paused = false



func _on_continue_pressed() -> void:
	pause_menue.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false


func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_quit_2_pressed() -> void:
	get_tree().quit()

func _on_option_pressed() -> void:
	option_menue.visible = true


func _on_button_pressed() -> void:
	option_menue.visible = false

func _on_replay_pressed() -> void:
	get_tree().reload_current_scene()
	get_tree().paused = false
