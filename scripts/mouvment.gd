extends State

@export var walk_speed : float
@export var sprint_speed : float
@export var sensetivity : float
@export var camera : Camera3D
@export var head : Node3D
@export var bob_freq : float
@export var bob_amp : float
@export var base_fov : float
@export var stamina : ProgressBar
@export var sensitivity_slider : HSlider
@export var sens_label : Label


var speed = walk_speed
var t_bob = 0.0
var fov_change = 1.5
var can_sprint = true
func _ready() -> void:
	sensitivity_slider.value = sensetivity * 1000
	sens_label.text = str(sensitivity_slider.value)

func process_physics(delta: float) -> State:
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()


	if parent.is_on_floor() :
		if direction :
			parent.velocity.x = direction.x * speed * delta 
			parent.velocity.z = direction.z * speed * delta 

		else:
			parent.velocity.x = lerp(parent.velocity.x , direction.x * speed * delta, delta * 4.0 )
			parent.velocity.z = lerp(parent.velocity.z , direction.z * speed * delta, delta * 4.0 )

	else :
		parent.velocity.x = lerp(parent.velocity.x , direction.x * speed * delta , delta * 2.0)
		parent.velocity.z = lerp(parent.velocity.z , direction.z * speed * delta , delta * 2.0)

	if stamina.value <=0.0 :
		can_sprint = false
	elif stamina.value >= 50.0  :
		can_sprint = true

	if Input.is_action_pressed("sprint") and can_sprint :
		speed = sprint_speed
		stamina.value -= delta * 20
	else :
		speed = walk_speed
		stamina.value += delta * 10



	parent.velocity.y -= gravity * delta



	parent.move_and_slide()

	t_bob += delta * parent.velocity.length() * float(parent.is_on_floor())
	camera.position = _headbob(t_bob)

	var velocity_clamped = clamp(parent.velocity.length() , 0.5 , sprint_speed * 2)
	var fov = base_fov + fov_change * velocity_clamped
	camera.fov = lerp(camera.fov , fov , delta * 8.0)
	
	return moving

func process_input(event: InputEvent) -> State:
	if event is InputEventMouseMotion :
		head.rotate_y(-event.relative.x * sensetivity)
		camera.rotate_x(-event.relative.y * sensetivity)
		camera.rotation.x = clamp(camera.rotation.x , deg_to_rad(-90) , deg_to_rad(90)) 
	return 

func _headbob(time) -> Vector3 :
	var pos = Vector3.ZERO
	pos.y = sin(time * bob_freq) * bob_amp
	pos.z = sin(time * bob_freq / 2) * bob_amp
	return pos


func _on_h_slider_value_changed(value: float) -> void:
	sensetivity = sensitivity_slider.value / 1000
	sens_label.text = str(sensitivity_slider.value)
