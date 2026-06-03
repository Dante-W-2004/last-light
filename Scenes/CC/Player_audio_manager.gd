extends AudioStreamPlayer
class_name PAManager

@export var hunger_sounds: Array[AudioStream] = []
@export var rare_audio_sound: AudioStream



func play_hunger_sound() -> void:
	var dice_roll = randi_range(1, 1000)
	
	if dice_roll == 1 and rare_audio_sound != null:
		stream = rare_audio_sound
		play()
	else:
		stream = hunger_sounds.pick_random()
		play()
