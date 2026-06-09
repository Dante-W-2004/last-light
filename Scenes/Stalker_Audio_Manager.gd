extends AudioStreamPlayer2D
class_name SAManager

@export var spawn_sounds: Array[AudioStream] = []
@export var spawn_sound_played : bool = false

@export var chase_state_sounds: Array[AudioStream] = []

func play_spawn_sound() -> void:
	if spawn_sound_played == false: 
		stream = spawn_sounds.pick_random()
		play()
		print("Playing")
		spawn_sound_played = true
	else:
		return
		
func play_chase_sounds() -> void: 
	var chase_sound_played = true
