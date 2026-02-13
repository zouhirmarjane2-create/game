extends Control

@export var brightness_slider : HSlider
@export var brightness_label : Label
@export var contraste_slider : HSlider
@export var contraste_label : Label
@export var world_envirment : WorldEnvironment

func _ready() -> void:
	brightness_slider.value = world_envirment.environment.adjustment_brightness * 50
	brightness_label.text = str(brightness_slider.value)
	contraste_slider.value = world_envirment.environment.adjustment_contrast * 50
	contraste_label.text = str(contraste_slider.value)

func _on_h_value_changed(value: float) -> void:
	world_envirment.environment.adjustment_brightness = brightness_slider.value / 50
	brightness_label.text = str(brightness_slider.value)


func _on_hh_value_changed(value: float) -> void:
	world_envirment.environment.adjustment_contrast = contraste_slider.value / 50
	contraste_label.text = str(contraste_slider.value)
