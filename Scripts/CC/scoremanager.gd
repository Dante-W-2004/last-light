extends BaseComponent
class_name Score

@export var score_label: Label

func set_score(_new_score: float) -> void:
	GlobalScore.score = _new_score
	update_label()
	
func modify_score(_score: float) -> void:
	GlobalScore.score += _score
	update_label()
	
func update_label() -> void:
	score_label.text = str(GlobalScore.score)
