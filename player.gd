extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -250.0
const BOUNCE_VELOCITY = -200.0

var bounce_mode = false
var in_front_of_lever = false
var x_bounce = 0
var facing = "right"
var coyote_time = true

@onready var _animated_sprite = $AnimatedSprite2D

func _process(delta):
	if bounce_mode == true:
		_animated_sprite.play("bounce_mode")
	else:
		if not is_on_floor():
			if velocity.y < 0:
				_animated_sprite.play("jump")
			else:
				_animated_sprite.play("fall")
		else:
			if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
				_animated_sprite.play("walk")
			else:
				_animated_sprite.play("idle")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
		if coyote_time == true:
			$Timer.start(.2)
	else:
		if bounce_mode == false:
			$Timer.stop
			coyote_time = true

	# Quick fall
	if !is_on_floor() and Input.is_action_just_released("ui_up") and velocity.y <= 0 and !bounce_mode:
		velocity.y = 0

	if bounce_mode:
		coyote_time = false

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and coyote_time == true:
		velocity.y = JUMP_VELOCITY
		coyote_time = false
	
	if bounce_mode and is_on_floor():
		velocity.y = BOUNCE_VELOCITY

	# Terminal velocity thingy
	if velocity.y > 600:
		velocity.y = 600

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if x_bounce == 0:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		velocity.x = x_bounce

	if Input.is_action_pressed("ui_left") and facing == "right":
		_animated_sprite.flip_h = true
		facing = "left"
	if Input.is_action_pressed("ui_right") and facing == "left":
		_animated_sprite.flip_h = false
		facing = "right"

	if x_bounce >= 20:
		x_bounce -= 30
	if x_bounce <= -20:
		x_bounce += 30
	if x_bounce < 20 and x_bounce > -20:
		x_bounce = 0

	move_and_slide()


func _on_main_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "key" and bounce_mode == false:
		bounce_mode = true
		Global.bounce_mode = true
		Global.timer = 8
		
	#if area.name == "lever" and !bounce_mode:
		#in_front_of_lever = true
		#print("hit lever")
	
	if area.name == "exit_door" and bounce_mode:
		Global.changing_scene = true
		

#func _on_main_area_2d_area_exited(area: Area2D) -> void:
	#if area.name == "lever":
		#in_front_of_lever = false
		#print("lever false")


func _on_right_area_2d_body_entered(body: Node2D) -> void:
	if bounce_mode:
		velocity.y = -200
		x_bounce = -300

func _on_left_area_2d_body_entered(body: Node2D) -> void:
	if bounce_mode:
		velocity.y = -200
		x_bounce = +300
#body.is_in_group("wall_check") and 


func _on_spike_detector_body_entered(body: Node2D) -> void:
	Global.bounce_mode = false
	Global.timer = 10
	Global.timer_ticking = false
	get_tree().call_deferred("reload_current_scene")


func _on_timer_timeout() -> void:
	coyote_time = false
