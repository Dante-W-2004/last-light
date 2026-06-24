extends AudioStreamPlayer2D
class_name SEAManager

@export var area_sounds: Array[AudioStream] = []

func _on_audio_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("boe")
		stream = area_sounds.pick_random()
		play()
