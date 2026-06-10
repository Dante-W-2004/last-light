extends StaticBody2D
class_name Campfire

@export var is_extractfire: bool = false
@export var animated_sprite: AnimatedSprite2D

signal canextract

func _ready() -> void:
	if is_extractfire:
		animated_sprite.play("extraction")
		canextract.emit()
