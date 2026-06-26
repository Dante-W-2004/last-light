extends BaseComponent
class_name TimerComponent

@export var auto_start: bool = false
@export var start_time: float = 0

var current_time: float = 0
var timing: bool = false 

signal timer_ended()

func _ready() -> void:
	if self.auto_start:
		start_timer()

func set_time(_new_time: float) -> void:
	self.current_time = _new_time
	
func modify_time(_time: float) -> void:
	self.current_time += _time
	
func start_timer(_start_time: float = 0) -> void:
	if _start_time > 0:
		self.start_time = _start_time
	self.current_time = self.start_time
	self.timing = true
	
func pause_timer() -> void:
	self.timing = false
	
func _physics_process(delta: float) -> void:
	if self.timing and self.current_time <= 0:
		timer_ended.emit()
		self.timing = false
	elif self.timing:
		self.current_time -= delta
