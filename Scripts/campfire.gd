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
	if body.is_in_group("player"):
		song_player.volume_db = -80.0
		var tween = get_tree().create_tween()
		song_player.play()
		
		tween.tween_property(song_player, "volume_db", 1.0, 2.0)
		print("Iets is de area binnengekomen ", body.name)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		var tween = get_tree().create_tween()
		
		tween.tween_property(song_player, "volume_db", -80.0, 5.0)
		print("bro is weg ", body.name)
		tween.tween_callback(song_player.stop)
