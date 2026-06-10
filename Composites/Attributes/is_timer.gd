extends BaseAttribute
class_name IsTimer

@export var start_time: float = 0
var current_time: float = 0
var timing: bool = false 

signal timer_ended()

func set_start_time(_new_time: float) -> void:
	self.start_time = _new_time

func set_time(_new_time: float) -> void:
	self.current_time = _new_time
	
func modify_time(_time: float) -> void:
	self.current_time += _time
	
func start_timer() -> void:
	timing = true
	
func stop_timer() -> void:
	timing = false	
	
func reset_timer() -> void:
	self.current_time = self.start_time
	
func _physics_process(delta: float) -> void:
	if self.current_time <= 0:
		timer_ended.emit()
	elif timing:
		self.current_time -= delta
