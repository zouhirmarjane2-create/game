extends Node3D

@export var hit_rec : ColorRect
@export var spawns : Node3D
@export var nav_reg : NavigationRegion3D

var zombie = load("res://scene/zombie.scn")
var inst

func _ready() -> void:
	randomize()

func _on_healt_player_hit() -> void:
	hit_rec.visible = true
	await get_tree().create_timer(0.2).timeout
	hit_rec.visible = false

func get_random_child(parent_node) :
	var randid = randi() % parent_node.get_child_count()
	return parent_node.get_child(randid)

func _on_timer_timeout() -> void:
	var spawn_point = get_random_child(spawns).global_position
	inst = zombie.instantiate()
	nav_reg.add_child(inst)
	inst.global_position = spawn_point
