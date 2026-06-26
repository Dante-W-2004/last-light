extends Node2D
class_name BaseItem

@export var item_data: BaseItemData

func _ready() -> void:
	self.add_to_group("Item")
	item_data.item_scene = load(scene_file_path)
	
	if item_data is BaseRandomItemData:
		if not item_data.randomised: 
			item_data.randomise_values()

func pick_up(_inventory: InventoryManager) -> void:
	var data: BaseItemData = item_data.duplicate(true)
	_inventory.add_to_inventory(data)
	self.queue_free()

func use(_affected: Node) -> void:
	for child in get_children():
		if child is BaseAttribute:
			child.modify(_affected)
