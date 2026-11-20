extends Node2D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Reiniciar"):
		get_tree().change_scene_to_file("res://Escenas/main.tscn")
