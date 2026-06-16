# Reusable parent class for all enemies.
# Sentry and Stalker will inherit from this script.
@abstract
extends CharacterBody2D
class_name BaseEnemyNew

# Shared enemy behavior states.
# Child enemies can use these states in their FSM.
enum State {
	IDLE,
	CHASE,
	ATTACK,
	DEAD
}

# Basic enemy stats.
# These can be adjusted per enemy in the Inspector.
@export var max_health: int = 30
@export var speed: float = 100.0
@export var detect_range: float = 250.0
@export var lose_range: float = 350.0
@export var attack_range: float = 35.0
@export var attack_damage: int = 5
@export var attack_cooldown: float = 1.5
@export var audio_manager: SAManager

# Runtime variables used while the game is running.
var health: int
var state: State = State.IDLE
var player: Player = null
var can_attack: bool = true

# Runs when the enemy spawns.
# Sets health, plays a spawn sound and finds the player.
func _ready():
	if audio_manager != null:
		audio_manager.play_spawn_sound()

	health = max_health
	find_player()

# Finds the first node inside the "player" group
# and stores a reference to it.
func find_player():
	var players = get_tree().get_nodes_in_group("player")

	if players.size() > 0:
		player = players[0]

# Empty state function.
# Child enemies should override this.
func idle_state():
	pass

# Empty state function.
# Child enemies should override this.
func chase_state():
	pass

# Empty state function.
# Child enemies should override this.
func attack_state():
	pass

# Empty attack function.
# Child enemies should override this.
func attack_player():
	pass

# Empty cooldown function.
# Child enemies should override this.
func cooldown():
	pass

# Empty death function.
# Child enemies should override this.
func dead_state():
	pass
