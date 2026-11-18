extends CharacterBody2D

var velocidad = 150

func _physics_process(delta):

	var direccion = Vector2.ZERO

	direccion.x = Input.get_action_strength("mover_derecha") - Input.get_action_strength("mover_izquierda")
	direccion.y = Input.get_action_strength("mover_abajo") - Input.get_action_strength("mover_arriba")
	velocity = direccion.normalized() * velocidad
	
	if Input.is_action_just_pressed("mover_derecha"):
		$Sprite2D.flip_h = false
	else:
		if Input.is_action_just_pressed("mover_izquierda"):
			$Sprite2D.flip_h = true
		
	move_and_slide()
