extends Node
class_name InventoryManager

@export var canvas: CanvasLayer

@export var max_weight: float = 0
var current_weight: float = 0

var items: Array[BaseItemData] = []

@export var pick_up_range: float = 25

signal inventory_changed()

func _ready() -> void:
	inventory_changed.emit()
	toggle_element_display(canvas)
	
func _input(event: InputEvent) -> void:
	if event.is_action_released("pick_up"):
		item_pick_up()
	elif event.is_action_released("toggle_inventory"):
		toggle_element_display(canvas)
		
func item_pick_up() -> void:
	var items: Array[Node] = get_tree().get_nodes_in_group("Item")
	var player: Player = get_tree().get_first_node_in_group("player")
	
	var closest_item: BaseItem
	var closest_distance: float = 2*pick_up_range
	
	for item: BaseItem in items:
		var item_distance: float = player.position.distance_to(item.position)
		if item_distance <= pick_up_range and item_distance < closest_distance:
			closest_item = item
			closest_distance = item_distance
	
	if closest_item:
		closest_item.pick_up(self)
	
func add_to_inventory(_item_data: BaseItemData) -> bool:
	if self.current_weight + _item_data.item_weight <= self.max_weight:
		items.append(_item_data)
		current_weight += _item_data.item_weight
		inventory_changed.emit()
		return true
	return false
	
func remove_from_inventory(_item_data: BaseItemData, _used: bool = false, _affected: Node = self) -> bool:
	
	if items.has(_item_data):
		if not _used:
			var temp_item: BaseItem = rebuild_item(_item_data)
			temp_item.global_position = get_tree().get_first_node_in_group("player").global_position
			get_tree().root.add_child(temp_item)
			
		else:
			var temp_item: BaseItem = rebuild_item(_item_data) 
			temp_item.use(_affected)
			temp_item.queue_free()
		
		items.erase(_item_data)
		current_weight -= _item_data.item_weight
		inventory_changed.emit()
		
		return true
	return false

func rebuild_item(_item_data: BaseItemData) -> BaseItem:
	var item_instance: BaseItem = _item_data.item_scene.instantiate()
	item_instance.item_data = _item_data.duplicate()
	return item_instance

func toggle_element_display(element: Node) -> void:
	element.visible = !element.visible
