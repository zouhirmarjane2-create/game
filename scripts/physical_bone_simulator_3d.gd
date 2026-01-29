extends PhysicalBone3D

@export var damage : float
signal body_hit(dam)

func _ready() -> void:
	add_to_group("enimi")

func hit() :
	emit_signal("body_hit" , damage)
