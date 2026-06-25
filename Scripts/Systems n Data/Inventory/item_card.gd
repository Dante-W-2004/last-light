extends Control
class_name ItemCard

@export var item_icon: TextureRect
@export var item_name: Label
@export var item_description: Label

@export var item_weight_value: Label
@export var item_value_value: Label
@export var item_rarity_value: Label

func update_item_card(_item_data: BaseItemData) -> void:
	item_icon.texture = _item_data.item_icon
	item_name.text = _item_data.item_name
	item_description.text = _item_data.item_description
	
	item_weight_value.text = str(_item_data.item_weight)
	item_value_value.text = str(_item_data.item_value)
	item_rarity_value.text = Rarity.Rarity.keys()[_item_data.item_rarity].capitalize()

func set_card_display(_visibility: bool = true, _allow_use: bool = false) -> void:
	for child: Control in get_children():
		if child == $UseButton:
			child.visible = _allow_use
		else:
			child.visible = _visibility
