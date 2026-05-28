extends Node2D

enum State {
	IDLE,
	ATTACK,
	DEAD
}

@export var health: int = 20
@export var attack_damage: int = 10
@export var attack_cooldown: float = 1.5

var state: State = State.IDLE
var player: Node2D = null
var can_attack: bool = true

func _process(delta):
	if state == State.DEAD:
		return

	if player != null and not player.is_dead:
		state = State.ATTACK
		attack_state()
	else:
		state = State.IDLE

func attack_state():
	if can_attack:
		attack_player()

func attack_player():
	can_attack = false

	if player != null and not player.is_dead and player.has_method("take_damage"):
		player.take_damage(attack_damage)
		print("Sentry attacked")

	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true

func take_damage(amount: int):
	if state == State.DEAD:
		return

	health -= amount

	if health <= 0:
		die()

func die():
	state = State.DEAD
	queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player = body

func _on_area_2d_body_exited(body):
	if body == player:
		player = null
