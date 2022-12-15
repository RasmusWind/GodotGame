extends Node

func _ready():
	Net.set_ids()
	create_players()
	
func create_players():
	for id in Net.peer_ids:
		create_player(id)
	create_player(Net.net_id)
	
func create_player(id):
	var p = preload("res://player/player_object.tscn").instance()
	var players_node = get_node("Players")
	players_node.add_child(p)
	p.initialize(id)
	p.get_node("SpringArm/Camera").current = true

func _input(ev):
	if ev is InputEventKey and ev.scancode == KEY_ESCAPE:
		get_tree().change_scene("res://menu/main_menu.tscn")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
