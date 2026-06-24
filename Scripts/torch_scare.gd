extends Area2D

@export var is_monitoring: bool = false

func _ready() -> void:
	monitoring = is_monitoring
	visible = false

func _on_body_entered(body: Node2D) -> void:
	if body is BaseEnemy:
		body.state = body.State.DEAD
