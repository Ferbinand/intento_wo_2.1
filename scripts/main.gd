extends Node
var tiempo_partida = 100
var label_partida_timer = Label

func _ready() -> void:
	print("partida empezada")
	$PartidaTimer.start()

func actualizar_txt_timer():
	$InfoPartida/Label.text = str(tiempo_partida)

func _on_partida_timer_timeout():
	tiempo_partida -= 1
	actualizar_txt_timer()
	# Finalizar la partida si el tiempo llega a 0
	if tiempo_partida <= 0:
		$PartidaTimer.stop()
		terminar_partida()
	pass # Replace with function body.

func terminar_partida():
	print("Partida finalizada")
