extends Area2D
@export_multiline var texto: String = ""

@onready var tecla: Label = $tecla
@onready var panel: Control = $PanelContainer
@onready var label: Label = $PanelContainer/MarginContainer/Label

var jugador_cerca := false
var abierto := false

func _ready() -> void:
	tecla.hide()
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("jugador"):
		jugador_cerca = true
		if not abierto:
			tecla.show()

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("jugador"):
		jugador_cerca = false
		tecla.hide()
		if abierto:
			cerrar()

func _unhandled_input(event: InputEvent) -> void:
	if jugador_cerca and event.is_action_pressed("interactuar"):
		if abierto:
			cerrar()
		else:
			abrir()

func abrir() -> void:
	abierto = true
	tecla.hide()
	label.text = texto
	panel.show()

func cerrar() -> void:
	abierto = false
	panel.hide()
	if jugador_cerca:
		tecla.show()
