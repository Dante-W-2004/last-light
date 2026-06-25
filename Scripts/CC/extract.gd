extends BaseComponent
class_name Extract

@export var extract_zone: Area2D
@export var extract_menu: PackedScene
var is_extract:bool = false

signal enterextract

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("extract"):
		print("button pess")
		print(len(extract_zone.get_overlapping_bodies()))
		for body in extract_zone.get_overlapping_bodies():
			print(body.name)
			if body is Player and is_extract:
				print("player found")
				GlobalScore.is_on_menu = true
				get_tree().change_scene_to_packed(extract_menu)

func _on_campfire_canextract() -> void:
	is_extract = true
