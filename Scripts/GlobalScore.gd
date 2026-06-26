extends Node

var score: float = 0
var high_score: float = 0
var is_dead: bool = false

func update_high_score() -> void:
	if GlobalScore.score > GlobalScore.high_score:
		GlobalScore.high_score = GlobalScore.score
