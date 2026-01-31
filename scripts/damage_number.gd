extends Node

func display_number(value : int , position : Vector2) :
	var number = Label.new()
	number.global_position = position
	number.text = str(value)
	number.z_index = 5
	number.label_settings = LabelSettings.new()
	
	var clor ="#FFF"
	if value == 80 :
		clor="b22"
	elif  value == 40 :
		clor = "#FFFF00"
	
	number.label_settings.font_color = clor
	number.label_settings.font_size = 64
	number.label_settings.font = load("res://texture/RushDriver-Italic.otf")
	number.label_settings.outline_color = "#000"
	number.label_settings.outline_size = 1
	
	
	call_deferred("add_child" , number)
	
	await number.resized
	number.pivot_offset = Vector2(number.size / 2)
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(number, "position:y", number.position.y - 600, 2).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(number, "scale", Vector2.ZERO, 0.25).set_delay(0.2)
	await tween.finished
	number.queue_free()
