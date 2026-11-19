extends CharacterBody2D
@export var Jugador: CharacterBody2D
var velocidad = 50

func _process(delta: float) -> void:
	var DistanciaJugador = position.distance_to(Jugador.position)
	if DistanciaJugador < 50:
		Atacar()
	elif DistanciaJugador < 300: 
		Perseguir()
	else:
		pass

func Perseguir():
	velocity = position.direction_to(Jugador.position) * velocidad
	move_and_slide()

func Atacar():
	print("Ataque")
