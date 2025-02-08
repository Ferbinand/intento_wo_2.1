extends Area2D
signal hacer_damage(cantidad)
var damage = 10

func _ready():
	# Configuración inicial o temporizador para autodestruirse
	await get_tree().create_timer(1).timeout
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("jugador")):
		print("has recibido " + str(damage) + " de daño")
		body.tomar_damage(damage)
	pass # Replace with function body.
