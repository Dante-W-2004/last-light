@abstract

extends CharacterBody2D
class_name BaseEnemy

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
@export var audio_manager: SAManager

# Runtime variables
var health: int
var state: State = State.IDLE
var player: Player = null
var can_attack: bool = true

# Sets health and finds the player when the enemy spawns
func _ready():
	audio_manager.play_spawn_sound()
	health = max_health
	find_player()
	
	# Finds the first node in the "player" group
func find_player():
	var players = get_tree().get_nodes_in_group("player")

	if players.size() > 0:
		player = players[0]
		

func idle_state():pass

func chase_state():pass
	
func attack_state():pass
	
func attack_player():pass

func cooldown():pass

func dead_state():pass
