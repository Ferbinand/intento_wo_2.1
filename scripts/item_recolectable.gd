extends Area2D
var random_range_object_id = randi_range(1,10) # Item que va del ID 1 a 10 (aumentar o disminuir)
@export var fall_speed := 200  # Velocidad de caída
var ground_y := 650  # Coordenada Y del suelo (ajusta según tu terreno)

func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("jugador")):
		body.sumar_item_inventario(random_range_object_id)
		queue_free()
	pass # Replace with function body.

func _process(delta):
	# Mover hacia abajo
	position.y += fall_speed * delta

	# Detener el movimiento al alcanzar el suelo
	if position.y >= ground_y:
		position.y = ground_y
		fall_speed = 0  # Detener la caída
