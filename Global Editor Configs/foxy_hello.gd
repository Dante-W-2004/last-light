@tool
extends Node

var random: RandomNumberGenerator
var random_chance_in: int = 10000

var time_since_last_attempt: float = 0
var jumpscare_scene: PackedScene = load("res://Global Editor Configs/jumpscare.tscn")
var jumpscare_sound: AudioStream = load("res://Global Editor Configs/foxy-jumpscare_sound.mp3")

func _ready() -> void:
	random = RandomNumberGenerator.new()

func _physics_process(delta: float) -> void:
	if not Engine.is_editor_hint():
		return
		
	time_since_last_attempt += delta

	if time_since_last_attempt >= 2:
		time_since_last_attempt = 0
		if random.randi_range(1, random_chance_in/2) == 1:
			play_jumpscare()

func play_jumpscare() -> void:
		var jumpscare: Control = jumpscare_scene.instantiate()
		get_tree().get_root().add_child(jumpscare)
		
		var animation: AnimatedSprite2D = jumpscare.get_child(0)
		animation.play("Jump")
		
		var player: AudioStreamPlayer = AudioStreamPlayer.new()
		jumpscare.add_child(player)
		player.stream = jumpscare_sound
		player.play()
		
		await animation.animation_finished
		animation.visible = false
		
		await player.finished
		get_tree().get_root().remove_child(jumpscare)
