extends CharacterBody2D
var velocidad = 150
const AGUA = preload("res://Escenas/agua_bendita.tscn")
var AguaLista = true
var CooldownAgua = 3
var EstacaLista = true
var CooldownEstaca = 6
var CruzLista = true
var CooldownCruz = 25
var direccion = Vector2.ZERO
var VidaMaxima := 100
var Vida := VidaMaxima
var Invulnerable = false
var Escudo = false
var ultima_direccion = Vector2() 
func _ready() -> void:
	ActualizarVida()
	$CDBarAgua.max_value = CooldownAgua
	$CDBarEstaca.max_value = CooldownEstaca
	$CDBarCruz.max_value = CooldownCruz
func _physics_process(_delta):
	Mover()
	ActualizarCooldowns()
	if direccion != Vector2.ZERO:
		ultima_direccion = direccion.normalized()
	Animar()
	if Input.is_action_just_pressed("TirarAgua") and AguaLista == true:
		TirarAgua()
	if  Input.is_action_just_pressed("UsarEstaca") and EstacaLista == true:
		UsarEstaca()
	if  Input.is_action_just_pressed("UsarCruz") and CruzLista == true:
		UsarCruz()
func Mover():
	direccion.x = Input.get_action_strength("mover_derecha") - Input.get_action_strength("mover_izquierda")
	direccion.y = Input.get_action_strength("mover_abajo") - Input.get_action_strength("mover_arriba")
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
	if Escudo == true:
		$Escudo.play("EscudoActivo")
	
func TirarAgua():
	AguaLista = false
	$CD_Agua.start(CooldownAgua)
	var instanciaAgua = AGUA.instantiate()
	instanciaAgua.position = position
	instanciaAgua.Direccion = ultima_direccion
	add_child(instanciaAgua)
	
func UsarEstaca():
	EstacaLista = false
	$CD_Estaca.start(CooldownEstaca)
func UsarCruz():
	CruzLista = false
	$CD_Cruz.start(CooldownCruz)
	Escudo = true
	$Escudo.visible = true
	$Escudo.play("EscudoActivo")
func ActualizarVida():
	Vida = clampi(Vida, 0, VidaMaxima)
	$BarraVida.value = Vida
	print(Vida)

func ActualizarCooldowns():
	$CDBarAgua.value = $CD_Agua.time_left
	$CDBarCruz.value =  $CD_Cruz.time_left
	$CDBarEstaca.value =  $CD_Estaca.time_left
func _on_cd_agua_timeout() -> void:
	AguaLista = true
func _on_cd_estaca_timeout() -> void:
	EstacaLista = true
func _on_cd_cruz_timeout() -> void:
	CruzLista = true


func _on_hurtbox_area_entered(area: Area2D):
	if Invulnerable == false and Escudo == false:
		Invulnerable  = true
		$Invulnerabilidad.start()
		Vida -= area.Daño
		ActualizarVida()
	elif Invulnerable == false and Escudo == true:
		Escudo = false
		$Escudo.play("EscudoRoto")
func _on_invulnerabilidad_timeout() -> void:
	Invulnerable = false


func _on_escudo_animation_finished() -> void:
	$Escudo.visible = false
