extends AudioStreamPlayer
class_name PAManager

@export var hunger_sounds: Array[AudioStream] = []
@export var ambiance_sounds: Array[AudioStream] = []
@export var rare_hunger_sound: AudioStream
@export var rare_ambiance_sound: Array[AudioStream] = []
@export var footstep_sound: AudioStream
@export var swoosh_sounds: Array[AudioStream] = []

@export var spatial_player: AudioStreamPlayer2D
@export var swoosh_player : AudioStreamPlayer
@export var footstep_player : AudioStreamPlayer
@export var ambiance_player : AudioStreamPlayer

func play_hunger_sound() -> void:
	var dice_roll = randi_range(1, 1000)
	
	if dice_roll == 1 and rare_hunger_sound != null:
		stream = rare_hunger_sound
		play()
	elif hunger_sounds.size() > 0:
		stream = hunger_sounds.pick_random()
		play()

func play_ambiance_sound() -> void: 
	if not ambiance_player.is_playing():
		var dice_roll = randi_range(1, 200)
		var chosen_sound: AudioStream = null

		if dice_roll >= 1 and dice_roll <= 199:
			return
		elif dice_roll == 200: 
			if rare_ambiance_sound != null:
				spatial_player.stream = rare_ambiance_sound.pick_random()
				spatial_player.play()
	else:
		return

func player_is_moving() -> void: 
	if footstep_player.stream_paused: 
		footstep_player.stream_paused = false
	else: 
		if footstep_player.stream != footstep_sound:
			footstep_player.stream = footstep_sound
			footstep_player.play()

func player_isnot_moving() -> void: 
	footstep_player.stream_paused = true
	
func player_swoosh() -> void: 
	swoosh_player.stream = swoosh_sounds.pick_random()
	swoosh_player.play()
