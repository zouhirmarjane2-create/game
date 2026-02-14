extends Node3D

@export var hit_rec : ColorRect
@export var spawns : Node3D
@export var nav_reg : NavigationRegion3D
@export var cross_hair : TextureRect
@export var timer : Timer
@export var timer_label : Label
@export var enemy_remaining : Label
var zombie = load("res://scene/zombie.scn")
var inst
var timer_started = false
var wave = 0


func _ready() -> void:
	randomize()
	cross_hair.position.x = get_viewport().size.x / 2 - 32
	cross_hair.position.y = get_viewport().size.y / 2 - 32


func _process(delta: float) -> void:
	var enemy = get_tree().get_nodes_in_group("enemy")
	enemy_remaining.text = str(enemy.size())
	timer_label.text = "next wave in : " + str("%0.2f" % timer.time_left)
	if enemy.is_empty() and not timer_started :
		timer.start()
		timer_started = true



func _on_healt_player_hit() -> void:
	hit_rec.visible = true
	await get_tree().create_timer(0.2).timeout
	hit_rec.visible = false

func get_random_child(parent_node) :
	var randid = randi() % parent_node.get_child_count()
	return parent_node.get_child(randid)

func _on_timer_2_timeout() -> void:
	wave += randi_range(1 , 3)
	
	timer.stop()
	for i in wave :
		var spawn_point = get_random_child(spawns).global_position
		inst = zombie.instantiate() 
		inst.add_to_group("enemy")
		nav_reg.add_child(inst)
		inst.global_position = spawn_point
	timer_started = false
