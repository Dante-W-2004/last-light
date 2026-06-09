extends BaseComponent
class_name Thirst

@export var max_thirst: float = 100
@export var drain_rate: float = 1
@export var thirst_damage: float = 5
@export var healthnode: Health
var current_thirst: float = max_thirst
var dehydrated: bool = false

signal thirst_changed(new_thirst)
signal on_dehydrate
signal broadcast_maxthirst(max_thirst)

func _ready() -> void:
	on_dehydrate.connect(dehydrate)

func dehydrate(delta: float):
	self.healthnode.modify_health(-self.thirst_damage * delta)

func _physics_process(delta: float) -> void:
	modify_thirst(-drain_rate * delta)
	
	if dehydrated and healthnode != null:
		dehydrate(delta)
		

func set_thirst(_new_value):
	current_thirst = _new_value
	current_thirst = clampf(current_thirst,0,max_thirst)
	thirst_changed.emit(current_thirst)
	if current_thirst <= 0 and not dehydrated:
		on_dehydrate.emit()
		dehydrated = true
	if current_thirst > 0:
		dehydrated = false

func modify_thirst(_hunger_modifier):
	current_thirst += _hunger_modifier
	current_thirst = clampf(current_thirst,0,max_thirst)
	thirst_changed.emit(current_thirst)
	if current_thirst <= 0 and not dehydrated:
		on_dehydrate.emit()
		dehydrated = true
	if current_thirst > 0:
		dehydrated = false
