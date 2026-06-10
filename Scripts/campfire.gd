extends StaticBody2D
class_name Campfire

@export var is_extractfire: bool = false

signal canextract

func _ready() -> void:
	if is_extractfire:
		canextract.emit()
