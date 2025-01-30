extends CanvasLayer
@export var slot_scene = preload("res://scenes/slot.tscn")
# Diccionario para mapear IDs con las instancias de los slots
var slots = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Crear instancias del slot dinámicamente y configurarlas
	for id in range(3, 11):  # IDs de 3 a 10
		var slot_instance = slot_scene.instantiate()
		slot_instance.set_id_inventario(id)  # Asignar ID al slot
		slots[id] = slot_instance  # Guardar la instancia en el diccionario
		
		# Añadir el slot al GridContainer
		$Control/PanelContainer/GridContainer.add_child(slot_instance)


func _on_jugador_recoger_item(id: Variant) -> void:
	if slots.has(id):  # Verificar si el ID existe en el diccionario
		var slot = slots[id]
		if(slot.cantidad == 0):
			# Añadir el slot al GridContainer con su imagen segun randi
			var ruta_imagen = "res://art/Items/item_" + str(id) +".png"
			slot.set_imagen(ruta_imagen)
			pass
		slot.cantidad += 1  # Incrementar la cantidad del slot
		slot.actualizar_cantidad()
		print("Cantidad en slot con ID", id, "es ahora:", slot.cantidad)
	else:
		print("El ID", id, "no corresponde a ningún slot.")


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed ("abrir_inventario"):
		if $Control/PanelContainer.visible == false:
			$Control/PanelContainer.show()
		else:
			$Control/PanelContainer.hide()
