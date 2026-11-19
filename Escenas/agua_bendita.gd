extends Area2D
var Velocidad = 150
var Direccion = Vector2()

func _physics_process(delta: float) -> void:
	position += Direccion * Velocidad * delta
	
func _on_body_entered(body: Node2D) -> void:
	Velocidad = 70
	rotation = Direccion.angle()
	$AnimatedSprite2D.play("Splash")
	
func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
