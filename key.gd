extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.bounce_mode == true:
		$AnimatedSprite2D.play("collected")
	else:
		$AnimatedSprite2D.play("default")
