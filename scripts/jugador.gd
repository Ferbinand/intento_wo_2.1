extends CharacterBody2D

# MOVIMIENTO
@export var speed := 200
@export var jump_force := -400
@export var gravity := 800
var vida_jugador = 100
@onready var animacion_jugador = $MovimientoJugador

#ITEMS
var items = []  # Lista para almacenar los objetos
@onready var arma_actual = 0  # ID del arma equipada
signal recoger_item(id)

#CALLABLE
var callable_damage = Callable(self,"tomar_damage")

@export var explosion_scene = preload("res://scenes/explosion.tscn")  # Asignar la escena de la explosion 
@export var proyectil_scene = preload("res://scenes/proyectil.tscn")  # Asignar la escena del proyectil
var tiene_arma = false  # Suponemos que el jugador tiene un arma equipada

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if tiene_arma:
			disparar_proyectil(event.position)

func disparar_proyectil(posicion_objetivo: Vector2):
	# Instanciar la explosion
	var explosion = explosion_scene.instantiate()
	var proyectil = proyectil_scene.instantiate()
	# Obtener la posición global de la punta del arma
	var punto_salida = $Item_equipado/Cabezal_item.global_position
	# Calcular la dirección y la fuerza inicial
	var direccion = (posicion_objetivo - punto_salida).normalized()
	var offset = direccion * 10  # Correccion sobre la direccion (entre mas, mas cerca del mouse estará)
	# Configurar la posición inicial del proyectil
	proyectil.global_position = punto_salida + offset
	# Determinar si el mouse está a la izquierda o derecha del jugador
	var mouse_pos = get_global_mouse_position()
	var jugador_pos = global_position
	proyectil.is_flip = mouse_pos.x < jugador_pos.x  # Flip si está a la izquierda
	# Conectar la señal 
	explosion.connect("hacer_damage", callable_damage, 0)
	get_tree().root.add_child(proyectil)  # Añadir la proyectil a la escena
	
	 #var fuerza = 500  # Ajustar según la fuerza deseada
	 #proyectil.apply_impulse(Vector2.ZERO, direccion * fuerza)

func _ready():
	items = cargar_items_json()
	if items.size() > 0:
		print("Objetos cargados del JSON:")
		for item in items:
			print(item)
	else:
		print("No se pudieron cargar los ítems.")

func _physics_process(delta):
	# Movimiento lateral
	if Input.is_action_pressed("mover_izquierda"):
		velocity.x = -speed
		animacion_jugador.flip_h = true
		animacion_jugador.play("run")
	elif Input.is_action_pressed("mover_derecha"):
		velocity.x = speed
		animacion_jugador.flip_h = false
		animacion_jugador.play("run")
	else:
		velocity.x = 0
		animacion_jugador.play("idle")
	# Salto
	if Input.is_action_just_pressed("saltar") and is_on_floor():
		velocity.y = jump_force
		animacion_jugador.play("jump")
	# Aplicar gravedad
	if not is_on_floor():
		velocity.y += gravity * delta
	# Mover el personaje
	move_and_slide()

# Función para cargar los datos del JSON
func cargar_items_json() -> Array:
	var json_path = "res://data/items.json"
	var file = FileAccess.open(json_path, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		file.close()
		
		# Parsear el contenido JSON
		var result = JSON.parse_string(content)
		if result is Dictionary and result.has("error"):
			print("Error al parsear JSON:", result.error_string)
		elif result is Array:
			return result
		else:
			print("El JSON no contiene un array en la raíz.")
	return []

# Función para que el personaje reciba daño
func tomar_damage(cantidad):
	vida_jugador -= cantidad
	if vida_jugador <= 0:
		vida_jugador = 0
		print("El personaje ha muerto")  # Esto puede reemplazarse con una lógica de muerte.
	$ColisionJugador/BarraDeVida.value = vida_jugador

func sumar_item_inventario(id_item_sumado):
	recoger_item.emit(id_item_sumado)

func equipar_arma(id):
	$Item_equipado.visible = true
	var ruta_imagen = "res://art/Items/item_" + str(id) +".png"
	var textura = load(ruta_imagen)  # Cargar textura 
	$Item_equipado/Imagen.texture = textura  # Asignar textura
	tiene_arma = true
