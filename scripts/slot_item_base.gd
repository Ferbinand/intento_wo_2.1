extends TextureRect

@onready var item = $Item
@onready var cantidad = 100

func _get_drag_data(at_position: Vector2) -> Variant:
	var data = {}
	return data

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true

func _drop_data(at_position: Vector2, data: Variant) -> void:
	pass

func restar_en_inventario():
	cantidad -= 1
	pass


func _on_mouse_entered() -> void:
	print("mouse marcando item BASE  la idea es hacer que resalte o que se marque con un cuadrado")
