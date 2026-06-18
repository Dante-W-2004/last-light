extends CharacterBody2D
class_name Player

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var speed: float = 200
@export var audio_manager: PAManager
@export var swing_cd: float = 2
@export var torch_area: Area2D
@export var extract_scene: String
@export var healthnode: Health
@onready var footsteps_play: bool = false

var can_swing: bool = true
signal swing
#update
func _ready():
	swing.connect(torch_swing)
	
func _physics_process(delta):
	get_input()
	move_and_slide()
	
	if velocity != Vector2.ZERO: 
		if footsteps_play == false: 
			audio_manager.player_is_moving()
			footsteps_play = true
	else:
		if footsteps_play == true:
			audio_manager.player_isnot_moving()
			footsteps_play = false

func get_input():
	look_at(get_global_mouse_position())
	var input_direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	if Input.is_action_just_pressed("swing") and can_swing:
		swing.emit()
		can_swing = false
		swing_cooldown()

func swing_cooldown():
	await get_tree().create_timer(swing_cd).timeout
	print("You may Swing")
	can_swing = true

func torch_swing():
	animated_sprite.play("swiping")
	audio_manager.player_swoosh()
	await get_tree().create_timer(.2).timeout
	var dir = (get_global_mouse_position() - global_position).normalized()
	torch_area.global_rotation = global_rotation
	torch_area.monitoring = true
	torch_area.visible = true
	await get_tree().create_timer(.8).timeout
	animated_sprite.play("idle")
	torch_area.monitoring = false
	torch_area.visible = false

#Audio
func _on_ambiance_timer_timeout() -> void: 
	if audio_manager != null: 
		audio_manager.play_ambiance_sound()

func _on_health_on_death() -> void:
	GlobalScore.score = 0
	get_tree().change_scene_to_file(extract_scene)
	
func take_damage(attack_damage) -> void:
	healthnode.modify_health(-attack_damage)
