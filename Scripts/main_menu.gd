extends Control

@export var playScene: String
@onready var sprite: Sprite2D = $TitlescreenLastLight

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file(playScene)



func _on_controls_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/control_menu.tscn")
