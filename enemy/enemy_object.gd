extends KinematicBody

var path = []
var path_node = 0

var speed = 5


onready var nav = get_parent()
var player = null
onready var platform = $"../NavigationMeshInstance/MeshInstance"

var player_start_pos = Vector3(0,0,0)
var start_pos
var enemy_pos
var player_pos
var platform_pos
var player_width = 0.6

var players = []
var closest_player = null

func _ready():
	start_pos = global_transform.origin
	platform_pos = platform.global_transform.origin

func _physics_process(_delta):
	players = get_tree().root.get_node("level_1/Players").get_children()
	enemy_pos = global_transform.origin
	for p in players:
		var p_vector = p.global_transform.origin
		print(p_vector)
		print(p_vector.x)
		if not closest_player:
			closest_player = p
		else:
			var p_distance = calculate_distance(enemy_pos, p_vector)
			var closest_distance = calculate_distance(enemy_pos, closest_player.global_transform.origin)
			if p_distance < closest_distance:
				closest_player = p
		
	if closest_player:
		player = closest_player
		player_pos = player.global_transform.origin
		if path_node < path.size():
			var direction = (path[path_node] - enemy_pos)
			if direction.length() < 0.6:
				path_node += 1
			else:
				var _move_and_slide = move_and_slide(direction.normalized() * speed, Vector3.UP)
		
		#check collision player vs enemy
		if player_pos != null:
			var threshold_distance = pow(0.6,2)
			var distance = calculate_distance(enemy_pos, player_pos)
			
			if threshold_distance >= distance:
				player.global_transform.origin = player_start_pos
			
#			var player_left_side = player_pos.x + (player_width / 2)
#			var player_right_side = player_pos.x - (player_width / 2)
#			var player_front_side = player_pos.z + (player_width / 2)
#			var player_back_side = player_pos.z - (player_width / 2)
#
#			var enemy_left_side = enemy_pos.x + (player_width / 2)
#			var enemy_right_side = enemy_pos.x - (player_width / 2)
#			var enemy_front_side = enemy_pos.z + (player_width / 2)
#			var enemy_back_side = enemy_pos.z - (player_width / 2)
#
#			var player_right_side_inside_enemy = player_right_side <= enemy_left_side and player_right_side >= enemy_right_side
#			var player_left_side_inside_enemy = player_left_side >= enemy_right_side and player_left_side <= enemy_left_side
#
#			var player_front_side_inside_enemy = player_front_side >= enemy_back_side and player_front_side <= enemy_front_side
#			var player_back_side_inside_enemy =  player_back_side <= enemy_front_side and player_back_side >= enemy_back_side
#
#			var player_left_or_right_inside = player_right_side_inside_enemy or player_left_side_inside_enemy
#			var player_front_or_back_inside = player_front_side_inside_enemy or player_back_side_inside_enemy
#
#			if player_left_or_right_inside and player_front_or_back_inside:
#				player.global_transform.origin = player_start_pos
		
func move_to(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)
	path_node = 0

func _on_Timer_timeout():
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
	
func calculate_distance(vector1, vector2):
	print(vector1.x)
	print(vector2.x)
	var distance = pow(vector1.x-vector2.x,2) + pow(vector1.y-vector2.y,2) + pow(vector1.z-vector2.z,2)
	return distance
