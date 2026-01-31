extends Label

var score : int = 0

func _on_zombie_dead() -> void:
	score += 1
	text = str(score)
