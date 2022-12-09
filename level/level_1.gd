extends Node

func _ready():
	pass 
	
func _input(ev):
	if ev is InputEventKey and ev.scancode == KEY_ESCAPE:
		get_tree().change_scene("res://menu/main_menu.tscn")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
