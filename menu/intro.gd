extends Node

func _ready():
	$AnimationPlayer.play("fadein")
	yield(get_tree().create_timer(2.5), "timeout")
	$AnimationPlayer.play("fadeout")
	yield(get_tree().create_timer(2.5), "timeout")
	get_tree().change_scene("res://menu/main_menu.tscn")
