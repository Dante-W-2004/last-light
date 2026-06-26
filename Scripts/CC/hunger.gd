extends ProgressBar

func _on_hunger_hunger_changed(new_hunger: Variant) -> void:
	self.value = floor(new_hunger)

func _on_hunger_broadcast_maxhunger(max_hunger: Variant) -> void:
	self.max_value = floor(max_hunger)
	self.value = floor(max_hunger)
