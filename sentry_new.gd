extends BaseEnemy
class_name SentryNew

@export var enemy_scene: PackedScene
@export var spawn_interval: float = 3.0
@export var isColliding: bool = false
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _physics_process(delta: float) -> void:
	if player == null:
		find_player()
	
	match state:
		State.DEAD:
			dead_state()
		State.ATTACK:
			attack_state()
		State.IDLE:
			idle_state()
	DamagePlayer()


func attack_state():
	if not can_attack:
		return
	
	can_attack = false
		
	if player != null and !GlobalScore.is_dead and player.has_method("take_damage"):
		player.take_damage(attack_damage)
		
	if !is_inside_tree():
			return
	await get_tree().create_timer(attack_cooldown).timeout
	
	can_attack = true

func dead_state():
	animated_sprite.play("death")
	set_physics_process(false)
	collision_shape.disabled = true

func idle_state():
	pass

func DamagePlayer() -> void:
	if not player or state == State.DEAD: return
	
	var distance = global_position.distance_to(player.global_position)
	if distance <= attack_range:
		state = State.ATTACK
	else:
		state = State.IDLE
