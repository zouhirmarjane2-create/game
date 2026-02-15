extends PhysicalBone3D



signal body_hit(dam)

func _ready() -> void:
	add_to_group("part")

func hit(dam) :
	emit_signal("body_hit" , dam)
	
