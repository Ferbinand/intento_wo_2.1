extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_jugador_recoger_item(id: Variant) -> void:
	get_node("Control/PanelContainer").sumar_item(id)
