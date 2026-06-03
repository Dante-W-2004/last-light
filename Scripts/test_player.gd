extends CharacterBody2D

# Player movement speed and maximum health
@export var speed: float = 200.0
@export var health: int = 100

# Tracks whether the player is alive or dead
var is_dead: bool = false


# Handles player movement every physics frame
func _physics_process(delta):

	# Reads keyboard movement input
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	# Applies movement speed to the direction
	velocity = input_direction * speed

	# Moves the player using Godot physics
	move_and_slide()


# Called when the player receives damage
func take_damage(amount: int):

	# Stops damage if the player is already dead
	if is_dead:
		return

	# Reduces player health
	health -= amount

	# Prints current player health
	print("Player HP: ", health)

	# Checks if health reached zero
	if health <= 0:
		is_dead = true
		print("Player died")


# Called when something enters the player's light detection area
func _on_light_detection_area_2d_body_entered(body: Node2D) -> void:

	# Ignore anything that is not an enemy
	if not body.is_in_group("enemy"):
		return

	# Enemy entered the light area
	print("Enemy entered light!")


# Called when something exits the player's light detection area
func _on_light_detection_area_2d_body_exited(body: Node2D) -> void:

	# Ignore anything that is not an enemy
	if not body.is_in_group("enemy"):
		return

	# Enemy exited the light area
	print("Enemy exited light!")
