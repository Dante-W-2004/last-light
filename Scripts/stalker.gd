extends CharacterBody2D

enum State {
	IDLE,
	CHASE,
	ATTACK,
	DEAD
}

@export var max_health: int = 30
@export var speed: float = 100.0
@export var detect_range: float = 250.0
@export var lose_range: float = 350.0
@export var attack_range: float = 35.0
@export var attack_damage: int = 10
@export var attack_cooldown: float = 1.5

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

var health: int
var state: State = State.IDLE
var player: Node2D = null
var can_attack: bool = true

func _ready():
	health = max_health
	find_player()

func _physics_process(delta):
	if state == State.DEAD:
		return

	if player == null:
		find_player()
		return

	match state:
		State.IDLE:
			idle_state()
		State.CHASE:
			chase_state()
		State.ATTACK:
			attack_state()

	move_and_slide()

func find_player():
	var players = get_tree().get_nodes_in_group("player")

	if players.size() > 0:
		player = players[0]

func idle_state():
	velocity = Vector2.ZERO

	var distance = global_position.distance_to(player.global_position)

	if distance <= detect_range:
		state = State.CHASE

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

func attack_state():
	var distance = global_position.distance_to(player.global_position)

	if distance > attack_range:
		state = State.CHASE
		return

	velocity = Vector2.ZERO

	if can_attack:
		attack_player()

func attack_player():
	can_attack = false

	if player.has_method("take_damage"):
		player.take_damage(attack_damage)

	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true

func take_damage(amount: int):
	if state == State.DEAD:
		return

	health -= amount
	print("Stalker HP: ", health)

	if health <= 0:
		die()
	else:
		state = State.CHASE

func die():
	state = State.DEAD
	velocity = Vector2.ZERO
	print("Stalker died")
	queue_free()
