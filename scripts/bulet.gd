extends Node3D


@export var bulet_speed : float
@export var mesh : MeshInstance3D
@export var raycast : RayCast3D 
@export var partcal : GPUParticles3D
@export var partical2 : GPUParticles3D
var damage = 20
var particals

func _process(delta: float) -> void:
	position += transform.basis * Vector3(0 , 0 , -bulet_speed) * delta
	
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.has_method("hit"):
			collider.hit(damage)
		if collider is PhysicalBone3D :
			partical2.emitting = true
			raycast.enabled = false
			mesh.queue_free()
			await get_tree().create_timer(1.0).timeout
			queue_free()
		else :
			partcal.emitting = true
			raycast.enabled = false
			mesh.queue_free()
			await get_tree().create_timer(1.0).timeout
			queue_free()
