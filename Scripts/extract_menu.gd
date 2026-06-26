extends Control
@export var score_label: Label
@export var high_score_label: Label
@export var level_scene: String

func _ready() -> void:
	score_label.text = str(GlobalScore.score)
	GlobalScore.update_high_score()
	high_score_label.text = str(GlobalScore.high_score)

func _on_play_again_button_pressed() -> void:
	GlobalScore.score=0
	get_tree().change_scene_to_file(level_scene)
	GlobalScore.is_dead = false

func _on_quit_button_pressed() -> void:
	get_tree().quit()
