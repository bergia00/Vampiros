extends CharacterBody2D

var velocidad = 150
const AGUA = preload("res://Escenas/agua_bendita.tscn")
var AguaLista = true
var CooldownAgua = 3 
var direccion = Vector2.ZERO

func _physics_process(delta):
	Mover()
	if Input.is_action_just_pressed("TirarAgua") and AguaLista == true:
		TirarAgua()
func Mover():
	
	direccion.x = Input.get_action_strength("mover_derecha") - Input.get_action_strength("mover_izquierda")
	direccion.y = Input.get_action_strength("mover_abajo") - Input.get_action_strength("mover_arriba")
	velocity = direccion.normalized() * velocidad
	if Input.is_action_just_pressed("mover_derecha"):
		$Sprite2D.flip_h = false
	elif Input.is_action_just_pressed("mover_izquierda"):
		$Sprite2D.flip_h = true
	move_and_slide()

func TirarAgua():
	AguaLista = false
	$CD_Agua.start(CooldownAgua)
	var instanciaAgua = AGUA.instantiate()
	instanciaAgua.position = position
	if direccion != Vector2(0, 0): 
		instanciaAgua.Direccion = direccion.normalized()
	elif direccion == Vector2(0, 0) and $Sprite2D.flip_h == true:
		instanciaAgua.Direccion = Vector2(-1, 0)
	else:
		instanciaAgua.Direccion = Vector2(1, 0)
	add_child(instanciaAgua)
	


func _on_cd_agua_timeout() -> void:
	AguaLista = true
	print("Agua lista")
