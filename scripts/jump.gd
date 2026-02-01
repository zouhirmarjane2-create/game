extends State
@export var jump_force: float = 9.18
var fall_gravity_multiplier = 2
@export var jump_sound : AudioStreamPlayer
@export var fall_sound : AudioStreamPlayer

var current_gravity = 0.0

func process_physics(delta: float) -> State:
	if parent.is_on_floor():
		if Input.is_action_just_pressed("jump"):
			jump_sound.pitch_scale = randf_range(0.8 , 1.2)
			jump_sound.play()
			parent.velocity.y = jump_force * delta 
			current_gravity = gravity
		else:
			parent.velocity.y = 0
			current_gravity = gravity
	else:
		if parent.velocity.y < 0 :
			current_gravity = gravity * fall_gravity_multiplier
			if parent.velocity.y < -10 :
				fall_sound.pitch_scale = randf_range(0.8 , 1.2)
				fall_sound.play()
		else:
			current_gravity = gravity
		parent.velocity.y -= current_gravity * delta
	return jump
