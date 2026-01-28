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
	
	
	move_and_slide()
	
func _target_in_range() -> bool :
	return global_position.distance_to(player.global_position) < attack_range
	
func hit_finish() :
	if global_position.distance_to(player.global_position) < attack_range + 2.0 :
		var dir = global_position.direction_to(player.global_position)
		healt_node.hit(dir)
	
