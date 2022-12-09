extends Spatial

export var start_unit_offset : float = 0.0
export var animation_speed : float = 1
onready var animation = $AnimationPlayer

func _ready():			
	var new_start_pos = start_unit_offset * (animation.current_animation_length / 2)
	animation.playback_speed = animation_speed
	animation.seek(new_start_pos)
