extends Area2D

var Daño = 10
var Pinchan = false
signal Stop

func _on_timer_timeout() -> void:
	Pinchan = true
	emit_signal("Stop")
	print("auch")

func _on_stop_frena() -> void:
	Pinchan = false
	$Timer.autostart
