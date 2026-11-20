extends CharacterBody2D
@export var Jugador: CharacterBody2D
var velocidad = 50
var PuedeAtacar = true
var CooldownAtaque = 2
const ATAQUE = preload("res://Escenas/ataque_enemigo.tscn")
const PROYECTIL = preload("res://Escenas/proyectil.tscn")
var PuedeDisparar =  true
var Daño = 20
var Vida = 500
var CooldownDisparo = 5
func _process(_delta: float) -> void:
	var DistanciaJugador = position.distance_to(Jugador.position)
	if DistanciaJugador < 75:
		Atacar()
	elif DistanciaJugador < 200 and PuedeDisparar:
		Disparar()
	elif DistanciaJugador < 300: 
		Perseguir()
	else:
		pass
	if Vida <= 0:
		queue_free()
func Perseguir():
	velocity = position.direction_to(Jugador.position) * velocidad
	move_and_slide()

func Atacar():
	if PuedeAtacar == true:
		PuedeAtacar = false
		$CD_Ataque.start(CooldownAtaque)
		var instanciaAtaque = ATAQUE.instantiate()
		instanciaAtaque.position = position.direction_to(Jugador.position) * 200
		instanciaAtaque.rotation = position.direction_to(Jugador.position).angle()
		instanciaAtaque.Daño = Daño
		add_child(instanciaAtaque)
func on_hit(daño_recibido: int):
	Vida -= daño_recibido
	print(Vida)

func Disparar():
	var instanciaProyectil = PROYECTIL.instantiate()
	instanciaProyectil.Tirador = self
	instanciaProyectil.Daño = Daño
	instanciaProyectil.Direccion = (Jugador.global_position - global_position).normalized()
	instanciaProyectil.rotation = instanciaProyectil.Direccion.angle()
	get_parent().add_child(instanciaProyectil)
	instanciaProyectil.global_position = global_position
	$CD_Proyectil.start(CooldownDisparo)
	PuedeDisparar = false
	
func _on_timer_timeout() -> void:
	PuedeAtacar = true
	
func _on_hitbox_area_entered(area: Area2D) -> void:
	Vida -= area.Daño
	print(Vida)


func _on_cd_proyectil_timeout() -> void:
	PuedeDisparar = true
