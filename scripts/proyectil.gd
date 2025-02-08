extends PhysicsBody2D

var explosion_scene = preload("res://scenes/explosion.tscn") 
@export var gravity = 9.8
var velocity: Vector2 = Vector2.ZERO
@export var rozamiento: float = 0.75 # Para simular fricción al detenerse

func _physics_process(delta: float) -> void:
	velocity.y += gravity
	position += velocity * delta  
	var collision_info = move_and_collide(velocity * delta)
	if(collision_info):
		velocity = velocity.bounce(collision_info.get_normal())
		velocity *= rozamiento
		if velocity.length() < 1:
			velocity = Vector2.ZERO
	pass

func _ready():
	# Configuración inicial o temporizador para autodestruirse
	await get_tree().create_timer(3).timeout
	explotar(10)
	await get_tree().create_timer(4).timeout
	queue_free()

func explotar(damage):
	var explosion_instanciate = explosion_scene.instantiate()
	add_child(explosion_instanciate)
	pass
