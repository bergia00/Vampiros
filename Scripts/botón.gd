extends Area2D

var Pisado = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Protagonista" and Pisado == false:
		Pisado = true
		$sonido.play()
		$Rejas.queue_free()
		$AnimatedSprite2D.play("Apretado")
