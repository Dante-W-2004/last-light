extends Control
@export var score_label: Label
@export var level_scene: String

func _ready() -> void:
	score_label.text = str(GlobalScore.score)

func _on_play_again_button_pressed() -> void:
	GlobalScore.score=0
	get_tree().change_scene_to_file(level_scene)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
