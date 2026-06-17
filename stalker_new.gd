extends BaseEnemy
class_name StalkerNew


# NavigationAgent2D handles pathfinding toward the player.
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D


# Runs every physics frame.
# The Stalker can wait, chase, attack, or die.
func _physics_process(delta):
	if state == State.DEAD:
		dead_state()
		return

	if player == null:
		find_player()
		velocity = Vector2.ZERO
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


# Waits until the player is close enough to detect.
func idle_state():
	velocity = Vector2.ZERO

	var distance = global_position.distance_to(player.global_position)

	if distance <= detect_range:
		state = State.CHASE


# Follows the player using NavigationAgent2D.
func chase_state():
	var distance = global_position.distance_to(player.global_position)

	if distance > lose_range:
		state = State.IDLE
		velocity = Vector2.ZERO
		return

	if distance <= attack_range:
		state = State.ATTACK
		velocity = Vector2.ZERO
		return

	nav_agent.target_position = player.global_position

	var next_position = nav_agent.get_next_path_position()
	var direction = global_position.direction_to(next_position)

	velocity = direction * speed


# Stops moving and attacks while inside attack range.
func attack_state():
	var distance = global_position.distance_to(player.global_position)

	if distance > attack_range:
		state = State.CHASE
		return

	velocity = Vector2.ZERO

	if can_attack and not GlobalScore.is_dead:
		attack_player()


# Damages the player, then waits before attacking again.
func attack_player():
	can_attack = false

	if player != null and !GlobalScore.is_dead and player.has_method("take_damage"):
		player.take_damage(attack_damage)
		print("Stalker attacked")
		if !is_inside_tree():
			return
		await get_tree().create_timer(attack_cooldown).timeout
		can_attack = true


# Removes the Stalker from the game when dead.
func dead_state():
	queue_free()
