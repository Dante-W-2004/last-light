extends ProgressBar

func _on_thirst_thirst_changed(new_thirst: Variant) -> void:
	self.value = floor(new_thirst)

func _on_thirst_broadcast_maxthirst(max_thirst: Variant) -> void:
	self.max_value = floor(max_thirst)
	self.value = floor(max_thirst)
