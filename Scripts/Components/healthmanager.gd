extends Node
class_name Health

@export var max_health: int = 100
var current_health: int = max_health

signal health_changed(new_health)
signal on_death()
signal broadcast_maxhealth(max_health)

func _ready() -> void:
	broadcast_maxhealth.emit(self.max_health)
