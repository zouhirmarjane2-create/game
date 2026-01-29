extends State

@export var gun_anime : AnimationPlayer
@export var bareel : RayCast3D
@export var gun_anime2 : AnimationPlayer
@export var bareel2 : RayCast3D

var buleet = load("res://scene/bulet.tscn")
var instance
var instance2

func process_physics(delta: float) -> State:
	if Input.is_action_pressed("shoot") :
		if !gun_anime.is_playing() :
			gun_anime.play("shoot")
			instance = buleet.instantiate()
			instance.position = bareel.global_position
			instance.transform.basis = bareel.global_transform.basis
			parent.get_parent().add_child(instance)
		if !gun_anime2.is_playing() :
			gun_anime2.play("shoot")
			instance2 = buleet.instantiate()
			instance2.position = bareel2.global_position
			instance2.transform.basis = bareel2.global_transform.basis
			parent.get_parent().add_child(instance2)
	return shot
