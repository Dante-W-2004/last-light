extends StaticBody2D
class_name Campfire

@export var is_extractfire: bool = false
@export var animated_sprite: AnimatedSprite2D
@onready var song_player = $CampfireSongPlayer

signal canextract

func _ready() -> void:
	if is_extractfire:
		animated_sprite.play("extraction")
		canextract.emit()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		song_player.play()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		song_player.stop()
