extends CharacterBody3D

var state_machine
var player = null
@export var speed : float
@onready var player_path = "/root/main/game/player"
@export var nav_agent : NavigationAgent3D
@export var anime_tree : AnimationTree
@export var attack_range : float
@onready var damage_origine = get_node("/root/main/damage_number_origine")

@onready var player_healt = "/root/main/game/player/code logic/healt"
var healt_node
var health = 200
var is_hit = false
var dami = 2
var is_dead = false
signal dead

func _ready() -> void:
	player = get_node(player_path)
	healt_node = get_node(player_healt)
	state_machine = anime_tree.get("parameters/playback")
	var score_label = get_node("/root/main/ui/healthetc/Panel/Label")
	dead.connect(score_label._on_zombie_dead)
func _process(delta: float) -> void:
	velocity = Vector3.ZERO
	if not is_hit :
		match state_machine.get_current_node() :
			"run":
				nav_agent.set_target_position(player.position)
				var next_nav_point = nav_agent.get_next_path_position()
				velocity = (next_nav_point - position).normalized() * speed * delta
				rotation.y = lerp_angle(rotation.y , atan2(-velocity.x , -velocity.z) , delta * 10)
			"punch" :
				look_at(Vector3(player.global_position.x , global_position.y , player.global_position.z) , Vector3.UP)
	


	
	anime_tree.set("parameters/conditions/punch" , _target_in_range())
	anime_tree.set("parameters/conditions/run" , !_target_in_range())
	if  health <= 0 and not is_dead  :
			is_dead = true
			anime_tree.set("parameters/conditions/die" , true)
			dead.emit()
			await get_tree().create_timer(4.0).timeout
			queue_free()
			return
	
	move_and_slide()
	
func _target_in_range() -> bool :
	return global_position.distance_to(player.global_position) < attack_range
	
func hit_finish() :
	if global_position.distance_to(player.global_position) < attack_range + 2.0 :
		var dir = global_position.direction_to(player.global_position)
		healt_node.hit(dir)
	








func _on_physical_bone_mixamorig_spine_1_body_hit(dam: Variant) -> void:
	health -= dam
	DamageNumber.display_number(dam , damage_origine.global_position)
	is_hit = true
	await get_tree().create_timer(0.1).timeout  #
	is_hit = false
func _on_physical_bone_mixamorig_head_body_hit(dam: Variant) -> void:
	health -= dam
	DamageNumber.display_number(dam , damage_origine.global_position )
	is_hit = true
	await get_tree().create_timer(0.5).timeout  
	is_hit = false
func _on_physical_bone_mixamorig_left_shoulder_body_hit(dam: Variant) -> void:
	health -= dam
	DamageNumber.display_number(dam , damage_origine.global_position)
	is_hit = true
	await get_tree().create_timer(0.1).timeout  #
	is_hit = false
func _on_physical_bone_mixamorig_left_arm_body_hit(dam: Variant) -> void:
	health -= dam
	DamageNumber.display_number(dam , damage_origine.global_position)
	is_hit = true
	await get_tree().create_timer(0.1).timeout  #
	is_hit = false
func _on_physical_bone_mixamorig_left_fore_arm_body_hit(dam: Variant) -> void:
	health -= dam
	DamageNumber.display_number(dam , damage_origine.global_position)
	is_hit = true
	await get_tree().create_timer(0.1).timeout  #
	is_hit = false
func _on_physical_bone_mixamorig_left_hand_body_hit(dam: Variant) -> void:
	health -= dam
	DamageNumber.display_number(dam , damage_origine.global_position)
	is_hit = true
	await get_tree().create_timer(0.1).timeout  #
	is_hit = false
func _on_physical_bone_mixamorig_right_shoulder_body_hit(dam: Variant) -> void:
	health -= dam
	DamageNumber.display_number(dam , damage_origine.global_position)
	is_hit = true
	await get_tree().create_timer(0.1).timeout  #
	is_hit = false
func _on_physical_bone_mixamorig_right_arm_body_hit(dam: Variant) -> void:
	health -= dam
	DamageNumber.display_number(dam , damage_origine.global_position)
	is_hit = true
	await get_tree().create_timer(0.1).timeout  #
	is_hit = false
func _on_physical_bone_mixamorig_right_fore_arm_body_hit(dam: Variant) -> void:
	health -= dam
	DamageNumber.display_number(dam , damage_origine.global_position)
	is_hit = true
	await get_tree().create_timer(0.1).timeout  #
	is_hit = false
func _on_physical_bone_mixamorig_right_hand_body_hit(dam: Variant) -> void:
	health -= dam
	DamageNumber.display_number(dam , damage_origine.global_position)
	is_hit = true
	await get_tree().create_timer(0.1).timeout  #
	is_hit = false
func _on_physical_bone_mixamorig_left_up_leg_body_hit(dam: Variant) -> void:
	health -= dam
	DamageNumber.display_number(dam , damage_origine.global_position)
	is_hit = true
	await get_tree().create_timer(0.1).timeout  #
	is_hit = false
func _on_physical_bone_mixamorig_left_leg_body_hit(dam: Variant) -> void:
	health -= dam
	DamageNumber.display_number(dam , damage_origine.global_position)
	is_hit = true
	await get_tree().create_timer(0.1).timeout  #
	is_hit = false
func _on_physical_bone_mixamorig_left_foot_body_hit(dam: Variant) -> void:
	health -= dam
	DamageNumber.display_number(dam , damage_origine.global_position)
	is_hit = true
	await get_tree().create_timer(0.1).timeout  #
	is_hit = false
func _on_physical_bonfe_mixamorig_right_up_leg_body_hit(dam: Variant) -> void:
	health -= dam
	DamageNumber.display_number(dam , damage_origine.global_position)
	is_hit = true
	await get_tree().create_timer(0.1).timeout  #
	is_hit = false
func _on_physical_bone_mixamorig_right_leg_body_hit(dam: Variant) -> void:
	health -= dam
	DamageNumber.display_number(dam , damage_origine.global_position)
	is_hit = true
	await get_tree().create_timer(0.1).timeout  #
	is_hit = false
func _on_physical_bone_mixamorig_right_foot_body_hit(dam: Variant) -> void:
	health -= dam
	DamageNumber.display_number(dam , damage_origine.global_position)
	is_hit = true
	await get_tree().create_timer(0.1).timeout  #
	is_hit = false
