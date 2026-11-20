extends Area2D

var Velocidad = 400
var Direccion = Vector2()
var Daño = 20
var Tirador: Node

func _physics_process(delta: float) -> void:
	position += Direccion * Velocidad * delta

func _on_area_entered(area: Area2D) -> void:
	if area == Tirador:
		return

	Velocidad = 0
	$AnimatedSprite2D.play("Splash")

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "Splash":
		queue_free()
