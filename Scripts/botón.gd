extends Area2D

var Pisado = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Protagonista" && Pisado == false:
		$Rejas.queue_free()
		Pisado = true
		$AnimatedSprite2D.play("Apretado")
		
