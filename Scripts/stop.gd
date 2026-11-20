extends Timer

signal Frena

func _on_pinches_1_stop() -> void:
	$".".start()

func _on_timeout() -> void:
	emit_signal("Frena")
