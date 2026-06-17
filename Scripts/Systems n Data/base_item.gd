extends Node2D
class_name BaseItem

@export var item_data: BaseItemData

func pick_up(_inventory: InventoryManager) -> void:
	var data: BaseItemData = item_data.duplicate()
	data.item_scene = load(scene_file_path)
	_inventory.add_to_inventory(data)
	self.queue_free()
