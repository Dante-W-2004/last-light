extends Control

@export var playScene: String

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file(playScene)
