extends Node

var current_level = 0
var lever_state =  false
var changing_scene = false

var timer = 9
var escape_time = 0
var timer_ticking = false
var bounce_mode = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if changing_scene:
		timer_ticking = false
		timer = 10
		lever_state = false
		current_level += 1
		bounce_mode = false
		
		if current_level == 1:
			get_tree().change_scene_to_file("res://levels/level1.tscn")
			escape_time = 1
		elif current_level == 2:
			get_tree().change_scene_to_file("res://levels/level2.tscn")
			escape_time = 1
		elif current_level == 3:
			get_tree().change_scene_to_file("res://levels/level3.tscn")
			escape_time = 1
		elif current_level == 4:
			get_tree().change_scene_to_file("res://levels/level4.tscn")
			escape_time = 1
		elif current_level == 5:
			get_tree().change_scene_to_file("res://levels/level5.tscn")
			escape_time = 1
		elif current_level == 6:
			get_tree().change_scene_to_file("res://levels/level6.tscn")
			escape_time = 1
		elif current_level == 7:
			get_tree().change_scene_to_file("res://levels/level7.tscn")
			escape_time = 1
		elif current_level == 8:
			get_tree().change_scene_to_file("res://levels/level8.tscn")
			escape_time = 1.5
		elif current_level == 9:
			get_tree().change_scene_to_file("res://levels/level9.tscn")
			escape_time = 1.5
		elif current_level == 10:
			get_tree().change_scene_to_file("res://levels/level10.tscn")
			escape_time = 1.5
		elif current_level == 11:
			get_tree().change_scene_to_file("res://levels/level11.tscn")
		elif current_level == 12:
			get_tree().quit()
		
		changing_scene = false
	
	if timer == 0:
		timer = 9
		get_tree().call_deferred("reload_current_scene")
		bounce_mode = false
		
	if timer < 9 and timer_ticking == false:
		timer_ticking = true
		await get_tree().create_timer(escape_time).timeout
		timer -= 1
		timer_ticking = false
