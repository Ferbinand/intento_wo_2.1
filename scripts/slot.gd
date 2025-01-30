extends TextureRect

@onready var item = $Item
@onready var cantidad = 0
@onready var cantidad_armas_inicial = 0
@export var id_inventario = 0

#func _get_drag_data(at_position: Vector2) -> Variant:
	#var data = {}
	#return data

#func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	#return true

#func _drop_data(at_position: Vector2, data: Variant) -> void:
	#pass

func restar_en_inventario():
	cantidad -= 1
	actualizar_cantidad()
	pass

func actualizar_cantidad():
	$CantidadLabel.text = str(cantidad)
	pass

func set_id_inventario(id)->void:
	id_inventario = id
	pass

func set_imagen(ruta) -> void:
	var nueva_textura = load(ruta)
	if nueva_textura and nueva_textura is Texture:
		texture = nueva_textura
	else:
		print("Error: La ruta no contiene una textura válida.")
	actualizar_cantidad()

func _on_mouse_entered() -> void:
	self.scale = Vector2(1.2, 1.2)

func _on_mouse_exited() -> void:
	# Restaurar el tamaño original
	self.scale = Vector2(1, 1)
