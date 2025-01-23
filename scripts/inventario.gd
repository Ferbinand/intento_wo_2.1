extends PanelContainer

@export var slot_scene = preload("res://scenes/slot.tscn")  # Cargar la escena de "slot"

func _process(delta: float) -> void:
	if Input.is_action_just_pressed ("abrir_inventario"):
		if visible == false:
			show()
		else:
			hide()


func sumar_item(id) -> void:
	# Crear una instancia del slot desde el PackedScene
	var slot = slot_scene.instantiate()
	# Añadir el slot al GridContainer con su imagen segun randi
	var ruta_imagen = "res://art/Items/item_" + str(id)
	slot.set_imagen(ruta_imagen)
	$GridContainer.add_child(slot)
	pass
