extends State



signal player_hit
var hit_stager = 12.0




func hit(dir) :
	emit_signal("player_hit")
	parent.velocity += clamp(dir * hit_stager , Vector3(1 , 0.0 , 1 ) , Vector3(20.0 , 0.0 , 20.0))
