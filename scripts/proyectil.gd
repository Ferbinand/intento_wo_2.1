extends Node2D
var explosion_scene = preload("res://scenes/explosion.tscn") 
@export var gravity = 9.8
@export var velocity = Vector2(450, -200)
var is_flip = false
@export var rozamiento: float = 0.9  # Para simular fricción al detenerse

func _process(delta):
	velocity.y += gravity
	position += velocity * delta  
	pass

func _ready():
	if(is_flip):
		velocity.x *= -1
	# Configuración inicial o temporizador para autodestruirse
	await get_tree().create_timer(3).timeout
	explotar(10)
	await get_tree().create_timer(4).timeout
	queue_free()

func explotar(damage):
	var explosion_instanciate = explosion_scene.instantiate()
	add_child(explosion_instanciate)
	pass
