extends CharacterBody2D

# Velocidad y fuerza de salto
@export var speed := 200
@export var jump_force := -400
@export var gravity := 800
var vida_jugador = 100
@onready var animacion_jugador = $MovimientoJugador
signal recoger_item(id)


func _ready():
	#label_vida = get_node("CollisionShape2D/Label")
	pass

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

# Función para que el personaje reciba daño
func tomar_daño(cantidad):
	vida_jugador -= cantidad
	if vida_jugador <= 0:
		vida_jugador = 0
		print("El personaje ha muerto")  # Esto puede reemplazarse con una lógica de muerte.
	$ColisionJugador/BarraDeVida.value = vida_jugador

func sumar_item_inventario(id_item_sumado):
	recoger_item.emit(id_item_sumado)

func equipar_arma():
	#$ItemEquipado.visible = true
	pass
