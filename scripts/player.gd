class_name Player
extends CharacterBody3D

@export var logic: State



func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	logic.process_input(event)

func _physics_process(delta: float) -> void:
	logic.process_physics(delta)
