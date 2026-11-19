extends CharacterBody2D

var velocidad = 150
const AGUA = preload("res://Escenas/agua_bendita.tscn")
var AguaLista = true
var CooldownAgua = 3
var direccion = Vector2.ZERO
var ultima_direccion = Vector2.DOWN

func _physics_process(_delta):
	Mover()
	Animar()
	if Input.is_action_just_pressed("TirarAgua") and AguaLista == true:
		TirarAgua()

func Mover():
	direccion.x = Input.get_action_strength("mover_derecha") - Input.get_action_strength("mover_izquierda")
	direccion.y = Input.get_action_strength("mover_abajo") - Input.get_action_strength("mover_arriba")
	if direccion != Vector2.ZERO:
		ultima_direccion = direccion.normalized()
	velocity = direccion.normalized() * velocidad
	move_and_slide()

func Animar():
	if direccion == Vector2.ZERO:
		$AnimatedSprite2D.animation = "mover_abajo"
		$AnimatedSprite2D.frame = 0
		$AnimatedSprite2D.pause()
		return
	# Si te movés en diagonal, gana el eje con más peso
	if abs(direccion.x) > abs(direccion.y):
		if direccion.x > 0:
			$AnimatedSprite2D.play("mover_derecha")
		else:
			$AnimatedSprite2D.play("mover_izquierda")
	else:
		if direccion.y > 0:
			$AnimatedSprite2D.play("mover_abajo")
		else:
			$AnimatedSprite2D.play("mover_arriba")

func TirarAgua():
	AguaLista = false
	$CD_Agua.start(CooldownAgua)
	var instanciaAgua = AGUA.instantiate()
	instanciaAgua.Direccion = ultima_direccion
	get_parent().add_child(instanciaAgua)
	instanciaAgua.global_position = global_position

func _on_cd_agua_timeout() -> void:
	AguaLista = true
