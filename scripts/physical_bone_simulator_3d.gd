extends PhysicalBone3D


@export var damage : float
signal body_hit(dam)

func hit() :
	emit_signal("body_hit" , damage)
	
