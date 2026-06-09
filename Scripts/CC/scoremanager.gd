extends Node

@export var scoreLabel: Label

func _process(delta: float) -> void:
	scoreLabel.text = str(GlobalScore.score)

func _on_button_pressed() -> void:
	GlobalScore.score += 10
