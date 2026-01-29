extends CharacterBody3D

var state_machine
var player = null
@export var speed : float
@onready var player_path = "/root/main/game/player"
@export var nav_agent : NavigationAgent3D
@export var anime_tree : AnimationTree
@export var attack_range : float

@onready var player_healt = "/root/main/game/player/code logic/healt"
var healt_node
var health = 20

var dami = 2

func _ready() -> void:
	player = get_node(player_path)
	healt_node = get_node(player_healt)
	state_machine = anime_tree.get("parameters/playback")
	
func _process(delta: float) -> void:
	velocity = Vector3.ZERO
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
	if health <= 0 :
		anime_tree.set("parameters/conditions/die" , true)
		await get_tree().create_timer(4.0).timeout
		queue_free()
	
	move_and_slide()
	
func _target_in_range() -> bool :
	return global_position.distance_to(player.global_position) < attack_range
	
func hit_finish() :
	if global_position.distance_to(player.global_position) < attack_range + 2.0 :
		var dir = global_position.direction_to(player.global_position)
		healt_node.hit(dir)
	








func _on_physical_bone_mixamorig_spine_1_body_hit(dam: Variant) -> void:
	health -= dam
func _on_physical_bone_mixamorig_head_body_hit(dam: Variant) -> void:
	health -= dam
func _on_physical_bone_mixamorig_left_shoulder_body_hit(dam: Variant) -> void:
	health -= dam
func _on_physical_bone_mixamorig_left_arm_body_hit(dam: Variant) -> void:
	health -= dam
func _on_physical_bone_mixamorig_left_fore_arm_body_hit(dam: Variant) -> void:
	health -= dam
func _on_physical_bone_mixamorig_left_hand_body_hit(dam: Variant) -> void:
	health -= dam
func _on_physical_bone_mixamorig_right_shoulder_body_hit(dam: Variant) -> void:
	health -= dam
func _on_physical_bone_mixamorig_right_arm_body_hit(dam: Variant) -> void:
	health -= dam
func _on_physical_bone_mixamorig_right_fore_arm_body_hit(dam: Variant) -> void:
	health -= dam
func _on_physical_bone_mixamorig_right_hand_body_hit(dam: Variant) -> void:
	health -= dam
func _on_physical_bone_mixamorig_left_up_leg_body_hit(dam: Variant) -> void:
	health -= dam
func _on_physical_bone_mixamorig_left_leg_body_hit(dam: Variant) -> void:
	health -= dam
func _on_physical_bone_mixamorig_left_foot_body_hit(dam: Variant) -> void:
	health -= dam
func _on_physical_bonfe_mixamorig_right_up_leg_body_hit(dam: Variant) -> void:
	health -= dam
func _on_physical_bone_mixamorig_right_leg_body_hit(dam: Variant) -> void:
	health -= dam
func _on_physical_bone_mixamorig_right_foot_body_hit(dam: Variant) -> void:
	health -= dam
