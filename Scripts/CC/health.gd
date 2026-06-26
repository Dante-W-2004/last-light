extends ProgressBar

func _on_health_health_changed(new_health: Variant) -> void:
	self.value = floor(new_health)

func _on_health_broadcast_maxhealth(max_health: Variant) -> void:
	self.max_value = floor(max_health)
	self.value = floor(max_health)
