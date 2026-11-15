extends Node2D

var started = false
var timer_going = false

@onready var _animated_sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.timer == 8 and started == false and timer_going == false:
		timer_going = true
		$Timer.start(.2)
		_animated_sprite.play("start")
		
	
	if Global.timer == 9:
		_animated_sprite.play("default")
	elif Global.timer == 7:
		_animated_sprite.play("clock_2")
	elif Global.timer == 6:
		_animated_sprite.play("clock_3")
	elif Global.timer == 5:
		_animated_sprite.play("clock_4")
	elif Global.timer == 4:
		_animated_sprite.play("clock_5")
	elif Global.timer == 3:
		_animated_sprite.play("clock_6")
	elif Global.timer == 2:
		_animated_sprite.play("clock_7")
	elif Global.timer == 1:
		_animated_sprite.play("clock_8")


func _on_timer_timeout() -> void:
	started = true
	_animated_sprite.play("clock_1")
	timer_going = false
