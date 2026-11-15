extends Node2D

@onready var _animated_sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.bounce_mode == true:
		_animated_sprite.play("open")
	else:
		_animated_sprite.play("default")
