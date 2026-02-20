extends RigidBody3D

@export var debree : GPUParticles3D
@export var fire : GPUParticles3D
@export var smoke : GPUParticles3D
@export var mesh : MeshInstance3D
@export var mesh2 : MeshInstance3D
@export var raduis : Area3D
@export var sound : AudioStreamPlayer

var damage = 400

func _on_body_entered(body: Node) -> void:
	fire.emitting = true
	debree.emitting = true
	smoke.emitting= true
	mesh.queue_free()
	mesh2.queue_free()
	sound.play()
	var bodies = raduis.get_overlapping_bodies()
	for obj in bodies :
		if obj.is_in_group("part") :
			obj.hit(damage)
	await get_tree().create_timer(2.0).timeout
	queue_free()
