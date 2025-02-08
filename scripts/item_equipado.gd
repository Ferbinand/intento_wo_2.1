extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#cargar imagen correspondiente
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if (rotation_degrees > 90 and rotation_degrees < 180):
		scale.y = -1
	else:
		scale.y = 1
	
