extends TextureRect

@onready var item = $Item
@onready var cantidad_armas_inicial = 0
@export var id_inventario = 0
@onready var cantidad = 0
#func _get_drag_data(at_position: Vector2) -> Variant:
	#var data = {}
	#return data

#func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	#return true

#func _drop_data(at_position: Vector2, data: Variant) -> void:
	#pass
func _ready() -> void:
	if(id_inventario == 1 or id_inventario == 2):
		self.set_cantidad(89)
		actualizar_cantidad()
		pass
	pass

func restar_en_inventario():
	cantidad -= 1
	actualizar_cantidad()
	pass

func actualizar_cantidad():
	$CantidadLabel.text = str(cantidad)
	pass

func set_id_inventario(id)->void:
	id_inventario = id

func set_cantidad(cant)->void:
	cantidad = cant

func set_imagen(ruta) -> void:
	var nueva_textura = load(ruta)
	if nueva_textura and nueva_textura is Texture:
		print(ruta)
		#texture = nueva_textura #POR AHORA EVITAR HASTA QUE HAYA IMAGENES DECENTES
	else:
		print("Error: La ruta no contiene una textura válida.")
	actualizar_cantidad()

func _on_mouse_entered() -> void:
	self.scale = Vector2(1.2, 1.2)
	print(str(cantidad))

func _on_mouse_exited() -> void:
	# Restaurar el tamaño original
	self.scale = Vector2(1, 1)
