extends CharacterBody3D


var player = null
@export var speed : float
@export var player_path : NodePath
@export var nav_agent : NavigationAgent3D


func _ready() -> void:
	player = get_node(player_path)
	
func _process(delta: float) -> void:
	velocity = Vector3.ZERO
	nav_agent.set_target_position(player.position)
	var next_nav_point = nav_agent.get_next_path_position()
	velocity = (next_nav_point - position).normalized() * speed
	move_and_slide()
