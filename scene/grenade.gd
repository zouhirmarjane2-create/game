extends RigidBody3D

@export var raduis : Area3D
var damage = 10

func _on_body_entered(body: Node) -> void:
	linear_damp = 0.3
	angular_damp = 1.5


func _on_timer_timeout() -> void:
	var bodies = raduis.get_overlapping_bodies()
	for obj in bodies :
		if obj.is_in_group("part") :
			obj.hit(damage)
	queue_free()
