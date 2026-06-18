extends BaseEnemy
class_name SentryNew

@export var enemy_scene: PackedScene
@export var tilemap: TileMap
@export var map_size: int = 200
@export var spawn_interval: float = 3.0
@export var isColliding: bool = false

#@onready var spawn_timer: Timer = $SpawnTimer

	#spawn_timer.wait_time = spawn_interval
	#spawn_timer.timeout.connect(spawn_enemy)
	#spawn_timer.start()
	

func _ready():
	if player == null:
		find_player()
	
	if isColliding:
		state = State.ATTACK
	else:
		state = State.IDLE
		
	match state:
		State.ATTACK:
			attack_state()
		State.IDLE:
			idle_state()
			


func attack_state(): 
	can_attack = false
	
	if player != null and !GlobalScore.is_dead and player.has_method("take_damage"):
		player.take_damage(attack_damage)
		print("Sentry attacked")
		
	if !is_inside_tree():
			return
	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true


func idle_state():
	pass


func _on_area_2d_body_shape_entered(body_rid: RID, body, body_shape_index: int, local_shape_index: int) -> void:
	var distance = global_position.distance_to(player.global_position)
	if distance <= 500:
		attack_state()
	else:
		idle_state()
