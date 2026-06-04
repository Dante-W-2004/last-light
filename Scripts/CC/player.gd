extends CharacterBody2D

@export var components: Dictionary[String,BaseComponent]
@export var speed: float = 400
@export var audio_manager: PAManager

#Movement
func get_input():
	look_at(get_global_mouse_position())
	var input_direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
	
func _on_ambiance_timer_timeout() -> void: 
	if audio_manager != null: 
		audio_manager.play_ambiance_sound()
