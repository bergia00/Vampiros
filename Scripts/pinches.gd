extends Area2D

var Daño = 0

func _ready() -> void:
	Pinches()

func Pinches():
	Daño = 0
	$Timer.start()

func _on_timer_timeout() -> void:
	$"Spikes down".play("No")
	$"Spikes down2".play("No")
	$Timer.stop()
	$Timer2.start()

func _on_timer_2_timeout() -> void:
	Daño = 10
	$"Spikes down".play("Sí")
	$"Spikes down2".play("Sí")
	$"Spikes down".play_backwards("Sí")
	$"Spikes down2".play_backwards("Sí")
	$Timer2.stop()
	$Timer3.start()
	
func _on_timer_3_timeout() -> void:
	Daño = 0
	$"Spikes down".play_backwards("No")
	$"Spikes down2".play_backwards("No")
	$Timer3.stop()
	Pinches()
