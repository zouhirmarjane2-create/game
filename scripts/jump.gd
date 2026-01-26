extends State
@export var jump_force: float = 9.18
var fall_gravity_multiplier = 2


var current_gravity = 0.0

func process_physics(delta: float) -> State:
	if parent.is_on_floor():
		if Input.is_action_just_pressed("jump"):
			parent.velocity.y = jump_force
			current_gravity = gravity
		else:
			parent.velocity.y = 0
			current_gravity = gravity
	else:
		if parent.velocity.y < 0:
			current_gravity = gravity * fall_gravity_multiplier
		else:
			current_gravity = gravity
		parent.velocity.y -= current_gravity * delta
	return jump
