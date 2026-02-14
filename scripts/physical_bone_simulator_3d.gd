extends PhysicalBone3D



signal body_hit(dam)

func hit(dam) :
	emit_signal("body_hit" , dam)
	
