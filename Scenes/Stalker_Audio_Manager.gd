extends AudioStreamPlayer2D
class_name SAManager

@export var spawn_sounds: Array[AudioStream] = []
@export var attack_sounds: Array[AudioStream] = []

@export var chase_state_sounds: Array[AudioStream] = []

func play_spawn_sound() -> void:
	stream = spawn_sounds.pick_random()
	play()
	print("Playing")
		
func play_attack_sound() -> void: 
	stream = attack_sounds.pick_random()
	play()
