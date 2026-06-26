extends BaseComponent
class_name Health

@export var max_health: float = 100
var current_health: float = max_health

signal health_changed(new_health)
signal on_death()
signal broadcast_maxhealth(max_health)

func _ready() -> void:
	broadcast_maxhealth.emit(self.max_health)

func set_health(_new_value):
	current_health = _new_value
	current_health = clampf(current_health,0,max_health)
	health_changed.emit(current_health)
	if current_health <= 0:
		on_death.emit()
		GlobalScore.is_dead = true

func modify_health(_health_modifier):
	current_health += _health_modifier
	current_health = clampf(current_health,0,max_health)
	health_changed.emit(current_health)
	if current_health <= 0:
		on_death.emit()
		GlobalScore.is_dead = true
