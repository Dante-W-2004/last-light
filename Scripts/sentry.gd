extends Node2D

# Possible behavior states for the Sentry enemy
enum State {
	IDLE,
	ATTACK,
	DEAD
}

# Enemy stats
@export var health: int = 20
@export var attack_damage: int = 10
@export var attack_cooldown: float = 1.5

# Runtime variables
var state: State = State.IDLE
var player: Node2D = null
var can_attack: bool = true

# Main behavior loop
func _process(delta):
	if state == State.DEAD:
		return

	# Checks if a living player exists
	if player != null and not player.is_dead:
		state = State.ATTACK
		attack_state()
	else:
		state = State.IDLE

# Starts attacking if the cooldown allows it
func attack_state():
	if can_attack:
		attack_player()

# Deals damage to the player
func attack_player():
	can_attack = false

	if player != null and not player.is_dead and player.has_method("take_damage"):
		player.take_damage(attack_damage)
		print("Sentry attacked")

	# Waits before attacking again
	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true

# Reduces health when the Sentry gets hit
func take_damage(amount: int):
	if state == State.DEAD:
		return

	health -= amount

	if health <= 0:
		die()

# Removes the Sentry when health reaches zero
func die():
	state = State.DEAD
	queue_free()

# Detects the player entering the Area2D
func _on_area_2d_body_entered(body):
	var players = get_tree().get_nodes_in_group("player")

	if players.size() > 0:
		player = players[0]

# Removes the player reference when they leave the Area2D
func _on_area_2d_body_exited(body):
	if body == player:
		player = null
