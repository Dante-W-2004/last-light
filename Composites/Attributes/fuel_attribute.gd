extends BaseAttribute
class_name FuelAttribute

@export var fuel_value: float = 0

func modify(affected: Node) -> void:
	var timer_component: TimerComponent = find_component(affected, TimerComponent)
	if timer_component:
		timer_component.modify_time(fuel_value)
