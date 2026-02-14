extends State
@export var gun : Node3D
@export var gun2 : Node3D
@export var revolver : Node3D
@export var gun_anime : AnimationPlayer
@export var bareel : RayCast3D
@export var gun_anime2 : AnimationPlayer
@export var bareel2 : RayCast3D
@export var revolver_anime : AnimationPlayer
@export var revolver_bareel : RayCast3D
@export var camera : Camera3D
@export var shot_ : AudioStreamPlayer
@export var shot_revolver : AudioStreamPlayer
@export var reload_revolver : AudioStreamPlayer
@export var reload_ : AudioStreamPlayer
@export var abylity_bar : ProgressBar
@export var ability : Panel
@export var head : Node3D
var total_magazin: int = 200
var total_revolver_magazin: int = 24
var revolver_shots = 0
var shots = 0
var ability_timer = 0
signal mele_hit()

var buleet = load("res://scene/bulet.tscn")
var instance
var instance2
@export var magzin_number : int = 30
@export var revolver_magzin_number : int = 8
@export var label : Label
var is_reloading = false
var main = true
var max_ = magzin_number
var max_revolver = revolver_magzin_number
var magazin : int = magzin_number
var revolver_magazine : int = revolver_magzin_number


func process_physics(delta: float) -> State:
	if total_magazin <= 0 :
		total_magazin =0
		magzin_number = 0
	elif total_magazin < magzin_number :
		magzin_number = total_magazin
	if total_revolver_magazin <= 0 :
		total_revolver_magazin =0
		revolver_magzin_number = 0
	elif total_revolver_magazin < revolver_magzin_number :
		revolver_magzin_number = total_revolver_magazin


	if ability_timer > 0 :
		ability_timer -= delta
		abylity_bar.value += delta * 13.33
	else :
		ability_timer = 0
		abylity_bar.value = 100



	if magazin <= 0 and not is_reloading and total_magazin > 0:
		magazin = 0
		reload()
	if revolver_magazine <= 0 and not is_reloading and total_revolver_magazin > 0:
		revolver_magazine = 0
		revolver_reload()

	if  Input.is_action_just_pressed("main ") :
		main_gun_swap()
		await get_tree().create_timer(1).timeout
		main_gun_swap()
	if  Input.is_action_just_pressed("secondary") :
		second_gun_swap()
		await get_tree().create_timer(1).timeout
		second_gun_swap()

	if main :
		ability.visible = false
		label.text = str(magazin) + "/" + str(total_magazin)
		clamp(magazin , 0 , max_)
		if Input.is_action_pressed("shoot") and not is_reloading :
			shoot()
			camera.rotation = lerp(camera.rotation , Vector3(
				camera.rotation.x + randf_range(-0.5 , 3) * delta , camera.rotation.y + randf_range(-2 , 2) * delta , 0 ) , delta * 8)
		else :
			shot_.stop()
		if Input.is_action_just_pressed("reload") and total_magazin > 0 and magazin < max_:
			reload()
	else :
		ability.visible = true
		label.text = str(revolver_magazine) + "/" + str(total_revolver_magazin)
		clamp(revolver_magazine , 0 , max_revolver)
		shot_.stop()
		if Input.is_action_just_pressed("ability") and not is_reloading and ability_timer <= 0:
			while revolver_magazine > 0 :
				revolver_shot()
				await get_tree().create_timer(0.01).timeout
			ability_timer = 7.5
			abylity_bar.value = 0
		if Input.is_action_just_pressed("shoot") and not is_reloading:
			revolver_shot()
			is_reloading = true
			await get_tree().create_timer(0.4).timeout
			is_reloading = false
		if Input.is_action_just_pressed("reload") and total_revolver_magazin > 0 and revolver_magazine < max_revolver:
			revolver_reload()

	return shot

func reload() :
	is_reloading = true
	gun_anime2.play("reload")
	gun_anime.play("reload")
	reload_.pitch_scale = randf_range(0.4, 0.8)
	reload_.play()
	await get_tree().create_timer(1.2).timeout
	magazin += shots
	is_reloading = false
	total_magazin -= shots
	shots = 0

func shoot():
	if magazin > 0 :
		if !gun_anime.is_playing() :
			magazin -= 1
			shots += 1
			gun_anime.play("shoot")
			shot_.pitch_scale = randf_range(8, 1.2)
			shot_.play()
			instance = buleet.instantiate()
			instance.position = bareel.global_position
			instance.transform.basis = bareel.global_transform.basis
			parent.get_parent().add_child(instance)
		if !gun_anime2.is_playing() :
			magazin -= 1
			shots +=1
			gun_anime2.play("shoot")
			instance2 = buleet.instantiate()
			instance2.position = bareel2.global_position
			instance2.transform.basis = bareel2.global_transform.basis
			parent.get_parent().add_child(instance2)



func revolver_shot() :
	if revolver_magazine >0 :
		if !revolver_anime.is_playing() :
			revolver_magazine -= 1
			revolver_shots += 1
			revolver_anime.play("shoot")
			shot_revolver.pitch_scale = randf_range(0.8, 1.2)
			shot_revolver.play()
			instance = buleet.instantiate()
			instance.position = revolver_bareel.global_position
			instance.transform.basis = revolver_bareel.global_transform.basis
			instance.scale = Vector3(3,3,3)
			parent.get_parent().add_child(instance)


func revolver_reload() :
	is_reloading = true
	revolver_anime.play("reload")
	reload_revolver.pitch_scale = randf_range(0.8, 1.2)
	reload_revolver.play()
	await get_tree().create_timer(1.5).timeout
	revolver_magazine += revolver_shots
	is_reloading = false
	total_revolver_magazin -= revolver_shots
	revolver_shots = 0

func melee_hit() :
	mele_hit.emit()
func main_gun_swap():
	if gun.position.y <= -1 :
		gun_anime.play("apear")
		gun_anime2.play("apear")
	if revolver.position.y >= -1 :
		revolver_anime.play("disapear")
		main = true
func second_gun_swap():
	if gun.position.y >= -1 :
		gun_anime.play("disapear")
		gun_anime2.play("disapear")
	if revolver.position.y <= -1 :
		revolver_anime.play("apear")
	main = false
