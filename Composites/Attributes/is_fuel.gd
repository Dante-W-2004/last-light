extends BaseAttribute
class_name IsFuel

@export var burn_time: float = 0

func is_burned(_affected: Node) -> void:
	for child in _affected.get_children(true):
		if child is IsTimer:
			child.modify_timer(burn_time)
