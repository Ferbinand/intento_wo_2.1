extends CanvasLayer
@export var slot_scene = preload("res://scenes/slot.tscn")
@onready var jugador = get_node("../Jugador")
@onready var callable = Callable(self, "_on_slot_seleccionado")
# Diccionario para mapear IDs con las instancias de los slots
var slots = {}

#SEÑALES


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for id in range(1, 3): # IDs de 1 a 2
		var slot_instance = slot_scene.instantiate()
		slot_instance.set_id_inventario(id)  # Asignar ID al slot
		slot_instance.set_cantidad(99) #asignamos a los item base un inicial
		
		if(id == 1):
			slot_instance.set_imagen("res://art/Items/espada.png")
		elif(id == 2):
			slot_instance.set_imagen("res://art/Items/granada.png")
		
		# Conectar la señal del slot al método _on_slot_seleccionado
		slot_instance.connect("seleccionar_item", callable, 0)
		
		slots[id] = slot_instance  # Guardar la instancia en el diccionario
		# Añadir el slot al GridContainer
		$Control/PanelContainer/GridContainer.add_child(slot_instance)
	# Crear instancias del slot dinámicamente y configurarlas
	for id in range(3, 11):  # IDs de 3 a 10
		var slot_instance = slot_scene.instantiate()
		slot_instance.set_id_inventario(id)  # Asignar ID al slot
		# Conectar la señal del slot al método _on_slot_seleccionado
		slot_instance.connect("seleccionar_item", callable, 0)
		
		slots[id] = slot_instance  # Guardar la instancia en el diccionario
		
		# Añadir el slot al GridContainer
		$Control/PanelContainer/GridContainer.add_child(slot_instance)

#Metodo para pasar al metodo de Jugador (si es online cada jugador debe tener su propio inventario (creo)
func _on_slot_seleccionado(id: int) -> void:
	print("ID del slot seleccionado:", id)
	jugador.equipar_arma(id)  # EL ID que se pasa viene de SLOT

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
