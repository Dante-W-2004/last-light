extends Node

@export var scoreLabel: Label


func _process(delta: float) -> void:
	scoreLabel.text = str(GlobalScore.score)
	if GlobalScore.is_on_menu:
		if GlobalScore.score > GlobalScore.high_score:
			GlobalScore.high_score = GlobalScore.score
	

func _on_button_pressed() -> void:
	GlobalScore.score += 10
