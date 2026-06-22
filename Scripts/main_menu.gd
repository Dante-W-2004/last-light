extends Control

@export var playScene: String

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file(playScene)



func _on_controls_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/control_menu.tscn")
