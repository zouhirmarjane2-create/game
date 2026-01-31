extends State

@export var gun_anime : AnimationPlayer
@export var bareel : RayCast3D
@export var gun_anime2 : AnimationPlayer
@export var bareel2 : RayCast3D
@export var camera : Camera3D

var buleet = load("res://scene/bulet.tscn")
var instance
var instance2
@export var magzin_number : int = 30
@export var label : Label
var is_reloading = false

var magazin : int = magzin_number
func process_physics(delta: float) -> State:
	label.text = str(magazin)
	if magazin <= 0 :
		magazin = 0
	if Input.is_action_pressed("shoot") and not is_reloading:
		shoot()
		camera.rotation.x = lerp(camera.rotation.x , camera.rotation.x + randf_range(-1 , 3) * delta , delta * 8)
		camera.rotation.y = lerp(camera.rotation.y , camera.rotation.y + randf_range(-3 , 3) * delta  , delta * 8)
	if Input.is_action_just_pressed("reload"):
		reload()
	return shot

func reload() :
	is_reloading = true
	gun_anime2.play("reload")
	gun_anime.play("reload")
	await get_tree().create_timer(1.2).timeout
	magazin = magzin_number
	is_reloading = false
func shoot():
	if magazin >0 :
		if !gun_anime.is_playing() :
			magazin -= 1
			gun_anime.play("shoot")
			instance = buleet.instantiate()
			instance.position = bareel.global_position
			instance.transform.basis = bareel.global_transform.basis
			parent.get_parent().add_child(instance)
		if !gun_anime2.is_playing() :
			magazin -= 1
			gun_anime2.play("shoot")
			instance2 = buleet.instantiate()
			instance2.position = bareel2.global_position
			instance2.transform.basis = bareel2.global_transform.basis
			parent.get_parent().add_child(instance2)
	else :
		reload()
