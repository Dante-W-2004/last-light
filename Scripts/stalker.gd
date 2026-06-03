extends CharacterBody2D

# Possible behavior states for the Stalker enemy
enum State {
	IDLE,
	CHASE,
	ATTACK,
	DEAD
}

# Enemy stats and behavior ranges
@export var max_health: int = 30
@export var speed: float = 100.0
@export var detect_range: float = 250.0
@export var lose_range: float = 350.0
@export var attack_range: float = 35.0
@export var attack_damage: int = 5
@export var attack_cooldown: float = 1.5

# NavigationAgent2D is used for pathfinding toward the player
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

# Runtime variables
var health: int
var state: State = State.IDLE
var player: Node2D = null
var can_attack: bool = true

# Sets health and finds the player when the enemy spawns
func _ready():
	health = max_health
	find_player()

# Main behavior loop for movement and state changes
func _physics_process(delta):
	if state == State.DEAD:
		return

	if player == null:
		find_player()
		velocity = Vector2.ZERO
		move_and_slide()
		return

	if player.is_dead:
		velocity = Vector2.ZERO
		state = State.IDLE
		move_and_slide()
		return

	match state:
		State.IDLE:
			idle_state()
		State.CHASE:
			chase_state()
		State.ATTACK:
			attack_state()

	move_and_slide()

# Finds the first node in the "player" group
func find_player():
	var players = get_tree().get_nodes_in_group("player")

	if players.size() > 0:
		player = players[0]

# Enemy waits until the player comes close enough
func idle_state():
	velocity = Vector2.ZERO

	var distance = global_position.distance_to(player.global_position)

	if distance <= detect_range:
		state = State.CHASE

# Enemy follows the player using pathfinding
func chase_state():
	var distance = global_position.distance_to(player.global_position)

	if distance > lose_range:
		velocity = Vector2.ZERO
		state = State.IDLE
		return

	if distance <= attack_range:
		velocity = Vector2.ZERO
		state = State.ATTACK
		return

	nav_agent.target_position = player.global_position

	var next_position = nav_agent.get_next_path_position()
	var direction = global_position.direction_to(next_position)

	velocity = direction * speed

# Enemy stops moving and attacks if close enough
func attack_state():
	var distance = global_position.distance_to(player.global_position)

	if distance > attack_range:
		state = State.CHASE
		return

	velocity = Vector2.ZERO

	if can_attack and not player.is_dead:
		attack_player()

# Deals damage, then waits before attacking again
func attack_player():
	can_attack = false

	if player != null and not player.is_dead and player.has_method("take_damage"):
		player.take_damage(attack_damage)
		print("Stalker attacked")

	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true

# Reduces enemy health when hit
func take_damage(amount: int):
	if state == State.DEAD:
		return

	health -= amount
	print("Stalker HP: ", health)

	if health <= 0:
		die()
	else:
		state = State.CHASE

# Removes the enemy when health reaches zero
func die():
	state = State.DEAD
	velocity = Vector2.ZERO
	print("Stalker died")
	queue_free()
