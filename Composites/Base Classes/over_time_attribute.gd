extends BaseAttribute
class_name OverTimeAttribute

@export var tick_interval: float = 0
@export var total_ticks: int = 0
@export var tick_delay: float = 0

func apply_over_time(component: Node, function: Callable, value: Variant) -> void:
	for i in total_ticks:
		var scene_timer: SceneTreeTimer = component.get_tree().create_timer(tick_interval * i + tick_delay)
		scene_timer.timeout.connect(function.bind(value), CONNECT_ONE_SHOT)
