extends CharacterBody2D

@export var speed: float = 200.0
@export var health: int = 100

func _physics_process(delta):
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed
	move_and_slide()

func take_damage(amount: int):
	health -= amount
	print("Player HP: ", health)

	if health <= 0:
		print("Player died")
