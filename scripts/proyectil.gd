extends RigidBody2D
var explosion_scene = preload("res://scenes/explosion.tscn")

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
