extends Label

var scoree : int = 0
signal score_added(scoree)
func _ready() -> void:
	text = str(scoree)

func _on_zombie_dead(reward) -> void:
	scoree += reward
	score_added.emit(scoree)
	text = str(scoree)


func _on_shot_score_remouved(score: Variant) -> void:
	scoree = score
	text = str(scoree)
