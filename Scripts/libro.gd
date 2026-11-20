extends Area2D
@export_multiline var texto: String = ""

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var tecla: Label = $tecla
@onready var panel: Control = $PanelContainer
@onready var label: Label =$PanelContainer/MarginContainer/Label

var jugador_cerca := false
var abierto := false

func _ready() -> void:
	tecla.hide()
	panel.hide()
	panel.z_index = 10 # para que se dibuje por encima de todo
	sprite.animation = "abrir"
	sprite.frame = 0
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
	sprite.play("abrir")
	await sprite.animation_finished
	if not abierto:
		return
	label.text = texto
	panel.reset_size()
	await get_tree().process_frame
	panel.position = Vector2(-panel.size.x * panel.scale.x / 2.0, -panel.size.y * panel.scale.y - 20)
	panel.show()

func cerrar() -> void:
	abierto = false
	panel.hide()
	sprite.play_backwards("abrir")
	await sprite.animation_finished
	if jugador_cerca and not abierto:
		tecla.show()
