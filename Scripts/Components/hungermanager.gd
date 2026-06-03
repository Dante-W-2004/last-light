extends BaseComponent
class_name Hunger

@export var max_hunger: float = 100
@export var drain_rate: float = .33
@export var hunger_damage: float = 5
@export var healthnode: Health
@export var hunger_audio_player: PAManager
var current_hunger: float = max_hunger
var starving: bool = false
var hunger_threshold = max_hunger * 0.25
var first_hunger_warning_played: bool = false
var last_hunger_warning_played: bool = false

signal hunger_changed(new_hunger)
signal on_starve()
signal broadcast_maxhunger(max_hunger)

func starve(delta: float):
	if current_hunger <= 0 and not last_hunger_warning_played:
		print("honger")
		hunger_audio_player.play_hunger_sound()
		last_hunger_warning_played = true
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
	if current_hunger <= hunger_threshold and not first_hunger_warning_played:
		print("honger")
		hunger_audio_player.play_hunger_sound()
		first_hunger_warning_played = true
	if current_hunger == hunger_threshold and first_hunger_warning_played:
		first_hunger_warning_played = false
