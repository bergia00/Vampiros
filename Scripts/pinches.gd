extends Area2D

var Pincha = false
var Daño = 0

func _ready() -> void:
	Pinches()

func Pinches():
	Pincha = false
	$Timer.start()

func _on_timer_timeout() -> void:
	$"Spikes down".play("No")
	$"Spikes down2".play("No")
	$Timer.stop()
	$Timer2.start()

func _on_timer_2_timeout() -> void:
	Pincha = true
	$"Spikes down".play("Sí")
	$"Spikes down2".play("Sí")
	$"Spikes down".play_backwards("Sí")
	$"Spikes down2".play_backwards("Sí")
	$Timer2.stop()
	$Timer3.start()
	
func _on_timer_3_timeout() -> void:
	Pincha = false
	$"Spikes down".play_backwards("No")
	$"Spikes down2".play_backwards("No")
	$Timer3.stop()
	Pinches()

func _on_body_entered(body: Node2D) -> void:
	if Pincha == true:
		Daño = 10
	
	if Pincha == false:
		Daño = 0
