extends BaseEnemy
class_name SentryNew


# Runs every frame.
# The Sentry does not move, so it only decides between IDLE, ATTACK and DEAD.
func _process(delta):
	if state == State.DEAD:
		dead_state()
		return

	if player != null and not player.is_dead:
		state = State.ATTACK
		attack_state()
	else:
		state = State.IDLE
		idle_state()


# Sentry does nothing while idle.
func idle_state():
	pass


# Starts an attack only if the cooldown is ready.
func attack_state():
	if can_attack:
		attack_player()


# Damages the player, then waits before attacking again.
func attack_player():
	can_attack = false

	if player != null and not player.is_dead and player.has_method("take_damage"):
		player.take_damage(attack_damage)
		print("Sentry attacked")

	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true


# Saves the player reference when the player enters the Sentry detection area.
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player = body


# Removes the player reference when the same player leaves the Sentry detection area.
func _on_area_2d_body_exited(body):
	if body == player:
		player = null


# Removes the Sentry from the game when dead.
func dead_state():
	queue_free()
