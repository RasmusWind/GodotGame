extends KinematicBody

var path = []
var path_node = 0

var speed = 5


onready var nav = get_parent()
onready var player = $"../../../../../Player"
onready var platform = $"../NavigationMeshInstance/MeshInstance"

var start_pos
var enemy_pos
var player_pos
var platform_pos

func _ready():
	start_pos = global_transform.origin
	platform_pos = platform.global_transform.origin
	pass 

func _physics_process(delta):
	if path_node < path.size():
		var direction = (path[path_node] - global_transform.origin)
		if direction.length() < 1:
			path_node += 1
		else:
			move_and_slide(direction.normalized() * speed, Vector3.UP)
	
	#check collision player vs enemy
		
func move_to(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)
	path_node = 0

func _on_Timer_timeout():
	enemy_pos = global_transform.origin
	player_pos = player.global_transform.origin
	print(player_pos)
	print(player_pos.x)
	print(player_pos.y)
	print(player_pos.z)
	var player_vs_playform_height = player_pos.y >= platform_pos.y and player_pos.y <= platform_pos.y + 10
	var player_vs_enemy_right = platform_pos.x + 10 < player_pos.x
	var player_vs_enemy_left = platform_pos.x - 10 > player_pos.x
	var player_vs_enemy_front = platform_pos.z - 10 > player_pos.z
	var player_vs_enemy_back = platform_pos.z + 10 < player_pos.z
		
	if player_vs_enemy_right or player_vs_enemy_left or player_vs_enemy_front or player_vs_enemy_back:
		if enemy_pos != start_pos:
			move_to(start_pos)
	elif player_vs_playform_height:
		move_to(player_pos)
	
