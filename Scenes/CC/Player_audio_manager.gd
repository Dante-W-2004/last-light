extends AudioStreamPlayer
class_name PAManager

@export var hunger_sounds: Array[AudioStream] = []
@export var ambiance_sounds: Array[AudioStream] = []
@export var rare_hunger_sound: AudioStream
@export var rare_ambiance_sound: Array[AudioStream] = []

func play_hunger_sound() -> void:
	var dice_roll = randi_range(1, 1000)
	
	if dice_roll == 1 and rare_hunger_sound != null:
		stream = rare_hunger_sound
		play()
	else:
		if hunger_sounds.size() > 0:
			stream = hunger_sounds.pick_random()
			play()

func play_ambiance_sound() -> void: 
	var dice_roll = randi_range(1, 200)
	var chosen_sound: AudioStream = null
	
	if dice_roll >= 1 and dice_roll <= 199:
		if ambiance_sounds.size() > 0:
			chosen_sound = ambiance_sounds.pick_random()
	elif dice_roll == 200: 
		if rare_ambiance_sound != null:
			chosen_sound = rare_ambiance_sound.pick_random()

	if chosen_sound != null:
		spawn_temporary_ambiance(chosen_sound)

func spawn_temporary_ambiance(sound: AudioStream) -> void:
	var temp_player = AudioStreamPlayer2D.new()
	temp_player.stream = sound
	
	var player_node = get_parent() as Node2D
	
	if player_node != null:
		var random_angle = randf_range(0, 2 * PI)
		var distance = 250.0 
		var offset = Vector2(cos(random_angle), sin(random_angle)) * distance

		temp_player.global_position = player_node.global_position + offset
		
		player_node.add_child(temp_player)
		temp_player.play()

		temp_player.finished.connect(func(): temp_player.queue_free())
