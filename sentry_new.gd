extends BaseEnemy
class_name SentryNew

@export var enemy_scene: PackedScene
@export var spawn_interval: float = 3.0
@export var isColliding: bool = false

func _physics_process(delta: float) -> void:
	if player == null:
		find_player()
	
	DamagePlayer()
		
	match state:
		State.ATTACK:
			attack_state()
		State.IDLE:
			idle_state()
			


func attack_state():
	if not can_attack:
		return
	
	can_attack = false
		
	print("Attack_State")
	if player != null and !GlobalScore.is_dead and player.has_method("take_damage"):
		player.take_damage(attack_damage)
		print("Sentry attacked")
		
	if !is_inside_tree():
			return
	await get_tree().create_timer(attack_cooldown).timeout
	
	can_attack = true


func idle_state():
	pass

func DamagePlayer() -> void:
	if not player: return
	
	var distance = global_position.distance_to(player.global_position)
	print("Distance: ", distance)
	if distance <= attack_range:
		print("Attacking")
		state = State.ATTACK
	else:
		print("Idle")
		state = State.IDLE
	
