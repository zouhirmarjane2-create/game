extends CharacterBody3D

var state_machine
var player = null
@export var speed : float
@onready var player_path = "/root/main/player"
@export var nav_agent : NavigationAgent3D
@export var anime_tree : AnimationTree
@export var attack_range : float
@onready var damage_origine = get_node("/root/main/damage_number_origine")
@export var take_dame_sound_1: AudioStreamPlayer
@export var take_dame_sound_2: AudioStreamPlayer
@export var take_dame_sound_3: AudioStreamPlayer
@export var zomnie_sound: AudioStreamPlayer
@export var death: AudioStreamPlayer
@export var punch: AudioStreamPlayer
@export var health_bar : ProgressBar
@onready var player_healt = "/root/main/player/code logic/healt"

var healt_node
var health 
var full_health
var is_hit = false
var dami = 2
var is_dead = false
signal dead
var i = 0
var zombie_sound_rand = 0
var sound_is_playing = false
var offset

func _ready() -> void:
	offset = Vector3(randf_range(-2.1 , 2.1) ,0 , randf_range(-2.1 , 2.1))
	health = randf_range(180 , 400)
	full_health = health
	scale = Vector3(health / 200 , health / 200 , health / 200)
	speed = speed * 290 / health 
	player = get_node(player_path)
	healt_node = get_node(player_healt)
	state_machine = anime_tree.get("parameters/playback")
	var score_label = get_node("/root/main/ui/healthetc/Panel/Label")
	dead.connect(score_label._on_zombie_dead)
	
func _physics_process(delta: float) -> void :
	velocity = Vector3.ZERO
	health_bar.value = health / full_health * 100

	

	
	i += delta
	if i > 1.0:
		var ii = randi() % 100 + 1
		if ii >= 85 and not zomnie_sound.playing:
			zomnie_sound.play()
			
		else :
			zomnie_sound.stop()
		i = 0.0
	
	if not is_hit :
		match state_machine.get_current_node() :
			"run":
				nav_agent.set_target_position(player.global_position + offset)
				var next_nav_point = nav_agent.get_next_path_position()
				velocity = (next_nav_point - global_position).normalized() * speed * delta
				rotation.y = lerp_angle(rotation.y , atan2(-velocity.x , -velocity.z) , delta * 10)
			"punch" :
				look_at(Vector3(player.global_position.x , global_position.y , player.global_position.z) , Vector3.UP)
	
	if global_position.distance_to(player.global_position) <= 45 :
		anime_tree.set("parameters/conditions/is_near" , true)
		anime_tree.set("parameters/conditions/is_not_near" , false)
	else :
		anime_tree.set("parameters/conditions/is_not_near" , true)
		anime_tree.set("parameters/conditions/is_near" , false)

	
	anime_tree.set("parameters/conditions/punch" , _target_in_range())
	anime_tree.set("parameters/conditions/run" , !_target_in_range())
	if  health <= 0 and not is_dead  :
			remove_from_group("enemy")
			is_dead = true
			anime_tree.set("parameters/conditions/die" , true)
			dead.emit()
			death.play()
			await get_tree().create_timer(4.0).timeout
			queue_free()
			return
	move_and_slide()
func _target_in_range() -> bool :
	return global_position.distance_to(player.global_position) < attack_range
	
func hit_finish() :
	if global_position.distance_to(player.global_position) < attack_range + 3.0 :
		var dir = global_position.direction_to(player.global_position)
		healt_node.hit(dir)
		punch.play()



func get_hit(dam , pr):
	var sound 
	var x = randi_range(1 , 3)
	if x == 1 :
		sound = take_dame_sound_1
	elif x == 2 :
		sound = take_dame_sound_2
	else :
		sound = take_dame_sound_3
	sound.play()
	sound.pitch_scale = randf_range(0.8 , 1.2)
	health -= dam
	DamageNumber.display_number(dam , damage_origine.global_position , pr)
	is_hit = true
	await get_tree().create_timer(0.1).timeout  #
	is_hit = false





func _on_physical_bone_mixamorig_spine_1_body_hit(dam: Variant) -> void:
	dam *= 2
	get_hit(dam , 1)
func _on_physical_bone_mixamorig_head_body_hit(dam: Variant) -> void:
	dam *= 4
	get_hit(dam , 0)
func _on_physical_bone_mixamorig_left_shoulder_body_hit(dam: Variant) -> void:
	get_hit(dam , 3)
func _on_physical_bone_mixamorig_left_arm_body_hit(dam: Variant) -> void:
	get_hit(dam , 3)
func _on_physical_bone_mixamorig_left_fore_arm_body_hit(dam: Variant) -> void:
	get_hit(dam , 3)
func _on_physical_bone_mixamorig_left_hand_body_hit(dam: Variant) -> void:
	get_hit(dam , 3)
func _on_physical_bone_mixamorig_right_shoulder_body_hit(dam: Variant) -> void:
	get_hit(dam , 3)
func _on_physical_bone_mixamorig_right_arm_body_hit(dam: Variant) -> void:
	get_hit(dam , 3)
func _on_physical_bone_mixamorig_right_fore_arm_body_hit(dam: Variant) -> void:
	get_hit(dam , 3)
func _on_physical_bone_mixamorig_right_hand_body_hit(dam: Variant) -> void:
	get_hit(dam , 3)
func _on_physical_bone_mixamorig_left_up_leg_body_hit(dam: Variant) -> void:
	get_hit(dam , 3)
func _on_physical_bone_mixamorig_left_leg_body_hit(dam: Variant) -> void:
	get_hit(dam , 3)
func _on_physical_bone_mixamorig_left_foot_body_hit(dam: Variant) -> void:
	get_hit(dam , 3)
func _on_physical_bonfe_mixamorig_right_up_leg_body_hit(dam: Variant) -> void:
	get_hit(dam , 3)
func _on_physical_bone_mixamorig_right_leg_body_hit(dam: Variant) -> void:
	get_hit(dam , 3)
func _on_physical_bone_mixamorig_right_foot_body_hit(dam: Variant) -> void:
	get_hit(dam , 3)
