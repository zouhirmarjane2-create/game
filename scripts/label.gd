extends Label

var scoree : int = 1000
signal score_added(scoree)
func _ready() -> void:
	text = str(scoree)

func _on_zombie_dead() -> void:
	scoree += 20
	score_added.emit(scoree)
	text = str(scoree)


func _on_shot_score_remouved(score: Variant) -> void:
	scoree = score
	text = str(scoree)
