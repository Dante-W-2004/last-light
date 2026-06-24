extends Label
class_name DynamicLabel

var base_font_size : int
var base_resultion : Vector2 = Vector2(1920, 1080)

func _enter_tree():
	base_font_size = self.label_settings.font_size
	get_viewport().size_changed.connect(set_text_size)

func _exit_tree():
	self.resized.disconnect(set_text_size)

func set_text_size():
	print("Changed")
	var new_size = get_viewport_rect().size
	var scale = new_size.x / base_resultion.x
	var scaled_size :int= clamp(floor(base_font_size * scale), 1, 4096)

	self.label_settings.font_size = scaled_size
