extends RigidBody3D

@export var raduis : Area3D
var damage = 15
@export var partical_system : GPUParticles3D
@export var partical_system1 : GPUParticles3D
@export var partical_system2 : GPUParticles3D
@export var grnade_sound : AudioStreamPlayer


func _on_body_entered(body: Node) -> void:
	linear_damp = 0.3
	angular_damp = 1.5


func _on_timer_timeout() -> void:
	partical_system.emitting = true
	partical_system2.emitting = true
	partical_system1	.emitting = true
	grnade_sound.play()
	var bodies = raduis.get_overlapping_bodies()
	for obj in bodies :
		if obj.is_in_group("part") :
			obj.hit(damage)
	await get_tree().create_timer(2).timeout
	queue_free()
