extends State
@export var gun : Node3D
@export var shot_gun : Node3D
@export var raycasts : Array[RayCast3D]
@export var shot_gun_anime : AnimationPlayer
@export var shot_shot_gun : AudioStreamPlayer
@export var shot_gun_reload : AudioStreamPlayer
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
var total_shot_gun_magazin : int = 0
var total_magazin: int = 0
var total_revolver_magazin: int = 8
var shot_gun_shots = 0
var revolver_shots = 0
var shots = 0
var ability_timer = 0
signal mele_hit()

var buleet = load("res://scene/bulet.tscn")
var instance
var instance2
@export var magzin_number : int = 30
@export var shot_gun_magzin_number : int = 16
@export var revolver_magzin_number : int = 8
@export var label : Label
var is_reloading = false
var main = false
var secondary = true
var max_ = magzin_number
var max_revolver = revolver_magzin_number
var max_shot_gun = shot_gun_magzin_number
var magazin : int = 30
var revolver_magazine : int = 8
var shot_gun_magazin : int = 16

var has_shot_gun = false
var has_smg = false
var has_ability = false
var score : int = 0
signal score_remouved(score)


func process_physics(delta: float) -> State:


	if ability_timer > 0 :
		ability_timer -= delta
		abylity_bar.value += delta * 13.33
	else :
		ability_timer = 0
		abylity_bar.value = 100



	if magazin <= 0 and not is_reloading and total_magazin > 0 and has_smg:
		magazin = 0
		reload()
	if revolver_magazine <= 0 and not is_reloading and total_revolver_magazin > 0:
		revolver_magazine = 0
		revolver_reload()
	if shot_gun_magazin <= 0 and not is_reloading and total_shot_gun_magazin > 0 and has_shot_gun:
		shot_gun_magazin = 0
		shot_gun__reload()

	if  Input.is_action_just_pressed("main ") and has_smg :
		main_gun_swap()
		await get_tree().create_timer(1).timeout
		main_gun_swap()
	elif  Input.is_action_just_pressed("secondary") :
		second_gun_swap()
		await get_tree().create_timer(1).timeout
		second_gun_swap()
	elif Input.is_action_just_pressed("third") and has_shot_gun:
		third_gun_swap()
		await get_tree().create_timer(1).timeout
		third_gun_swap()

	if main and has_smg :
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
	elif secondary :
		ability.visible = true
		label.text = str(revolver_magazine) + "/" + str(total_revolver_magazin)
		clamp(revolver_magazine , 0 , max_revolver)
		shot_.stop()
		if Input.is_action_just_pressed("ability") and not is_reloading and ability_timer <= 0 and has_ability:
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
	elif has_shot_gun :
		ability.visible = false
		label.text = str(shot_gun_magazin) + "/" + str(total_shot_gun_magazin)
		clamp(shot_gun_magazin , 0 , max_shot_gun)
		if Input.is_action_just_pressed("shoot") and not is_reloading :
			shot_gun_shot()
		if Input.is_action_just_pressed("reload") and total_shot_gun_magazin > 0 and shot_gun_magazin < max_shot_gun:
			shot_gun__reload()

	return shot

func reload() :
	is_reloading = true
	gun_anime2.play("reload")
	gun_anime.play("reload")
	reload_.pitch_scale = randf_range(0.4, 0.8)
	reload_.play()
	await get_tree().create_timer(1.2).timeout
	var amount_needed = max_ - magazin
	var amount_to_fill = min(amount_needed, total_magazin)
	magazin += amount_to_fill
	total_magazin -= amount_to_fill
	is_reloading = false
	shots = 0

func shoot():
	if magazin > 0 :
		if !gun_anime.is_playing() :
			magazin -= 1
			shots += 1
			gun_anime.play("shoot")
			shot_.pitch_scale = randf_range(0.8, 1.2)
			shot_.play()
			instance = buleet.instantiate()
			instance.damage = 10
			instance.position = bareel.global_position
			instance.transform.basis = bareel.global_transform.basis
			parent.get_parent().add_child(instance)
		if !gun_anime2.is_playing() :
			magazin -= 1
			shots +=1
			gun_anime2.play("shoot")
			instance2 = buleet.instantiate()
			instance.damage = 10
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
			instance.damage = 40
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
	var amount_needed = max_revolver - revolver_magazine
	var amount_to_fill = min(amount_needed, total_revolver_magazin)
	revolver_magazine += amount_to_fill
	total_revolver_magazin -= amount_to_fill
	is_reloading = false
	revolver_shots = 0


func shot_gun_shot() :
	if shot_gun_magazin >0 :
		if !shot_gun_anime.is_playing() :
			shot_gun_magazin -= 1
			shot_gun_shots += 1
			shot_gun_anime.play("shot")
			shot_shot_gun.pitch_scale = randf_range(0.8, 1.2)
			shot_shot_gun.play()
			for ray in raycasts :
				instance = buleet.instantiate()
				instance.damage = 20
				instance.position = ray.global_position
				instance.transform.basis = ray.global_transform.basis
				parent.get_parent().add_child(instance)

func shot_gun__reload() :
	is_reloading = true
	shot_gun_anime.play("relead")
	shot_gun_reload.pitch_scale = randf_range(0.8, 1.2)
	shot_gun_reload.play()
	await get_tree().create_timer(1.5).timeout
	var amount_needed = max_shot_gun - shot_gun_magazin
	var amount_to_fill = min(amount_needed, total_shot_gun_magazin)
	shot_gun_magazin  += amount_to_fill
	total_shot_gun_magazin -= amount_to_fill
	is_reloading = false
	shot_gun_shots = 0

func melee_hit() :
	mele_hit.emit()
func main_gun_swap():
	if gun.position.y <= -1 :
		gun_anime.play("apear")
		gun_anime2.play("apear")
	if revolver.position.y >= -1 :
		revolver_anime.play("disapear")
	if shot_gun.position.z <= 0 :
		shot_gun_anime.play("disapear")
	main = true
	secondary = false
func second_gun_swap():
	if gun.position.y >= -1 :
		gun_anime.play("disapear")
		gun_anime2.play("disapear")
	if revolver.position.y <= -1 :
		revolver_anime.play("apear")
	if shot_gun.position.z <= 0 :
		shot_gun_anime.play("disapear")
	main = false
	secondary = true

func third_gun_swap():
	if gun.position.y >= -1 :
		gun_anime.play("disapear")
		gun_anime2.play("disapear")
	if revolver.position.y >= -1 :
		revolver_anime.play("disapear")
	if shot_gun.position.z > 0 :
		shot_gun_anime.play("apear")
	main = false
	secondary = false


func _on_shot_gun_pressed() -> void:
	var price = 10
	if score >= price and not has_shot_gun :
		has_shot_gun = true
		score -= price
		score_remouved.emit(score)


func _on_shot_gun_ammo_pressed() -> void:
	var price = 2
	var ammo = 16
	if score >= price :
		total_shot_gun_magazin += ammo
		score -= price
		label.text = str(shot_gun_magazin) + "/" + str(total_shot_gun_magazin)
		score_remouved.emit(score)


func _on_smg_pressed() -> void:
	var price = 15
	if score >= price and not has_smg :
		has_smg = true
		score -= price
		score_remouved.emit(score)


func _on_smg_ammo_pressed() -> void:
	var price = 3
	var ammo = 30
	if score >= price :
		total_magazin += ammo
		score -= price
		label.text = str(magazin) + "/" + str(total_magazin)
		score_remouved.emit(score)


func _on_revolver_ammo_pressed() -> void:
	var price = 1
	var ammo = 10
	if score >= price :
		total_revolver_magazin += ammo
		score -= price
		label.text = str(revolver_magazine) + "/" + str(total_revolver_magazin)
		score_remouved.emit(score)


func _on_ability_pressed() -> void:
	var price = 5
	if score >= price and not has_ability :
		has_ability = true
		score -= price
		score_remouved.emit(score)


func _on_label_score_added(scoree: Variant) -> void:
	score = scoree
