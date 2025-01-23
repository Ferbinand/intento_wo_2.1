extends Node2D
var contador_general = 2
var sc_ItemRecolectable = preload("res://scenes/item_recolectable.tscn")

func _on_timer_timeout() -> void:
	contador_general+=1
	_spawn_item_recolectable(contador_general)
	pass # Replace with function body.

func _spawn_item_recolectable(tiempo):
	if((tiempo%5) == 0):
		var item_recolectable = sc_ItemRecolectable.instantiate()
		add_child(item_recolectable)
	pass
