extends BaseComponent
class_name Hunger

@export var max_hunger: float = 100
@export var drain_rate: float = .33
@export var hunger_damage: float = 5
@export var healthnode: Health
var current_hunger: float = max_hunger
var starving: bool = false

signal hunger_changed(new_hunger)
signal on_starve()
signal broadcast_maxhunger(max_hunger)

func starve(delta: float):
	self.healthnode.modify_health(-self.hunger_damage * delta)

func _physics_process(delta: float) -> void:
	modify_hunger(-drain_rate * delta)
	
	if starving and healthnode != null:
		starve(delta)

func set_hunger(_new_value):
	current_hunger = _new_value
	current_hunger = clampf(current_hunger,0,max_hunger)
	hunger_changed.emit(current_hunger)
	if current_hunger <= 0 and not starving:
		on_starve.emit()
		starving = true
	if current_hunger > 0:
		starving = false

func modify_hunger(_hunger_modifier):
	current_hunger += _hunger_modifier
	current_hunger = clampf(current_hunger,0,max_hunger)
	hunger_changed.emit(current_hunger)
	if current_hunger <= 0 and not starving:
		on_starve.emit()
		starving = true
	if current_hunger > 0:
		starving = false
