class_name State
extends Node

@export var jump: State
@export var moving: State
@export var parent: Player

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func process_input(event: InputEvent) -> State:
	moving.process_input(event)
	return null

func process_physics(delta: float) -> State:
	moving.process_physics(delta)
	jump.process_physics(delta)
	return null
