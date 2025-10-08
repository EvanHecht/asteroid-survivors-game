extends CharacterBody2D

@onready var sprite: Sprite2D = $sprite

@export var top_speed = 20
var current_speed = 0
var acceleration = 15
var direction = 0

func _process(delta: float) -> void:
	var input_vector = Input.get_vector("move_left", "move_right", "move_down", "accelerate")
	if input_vector.y > 0:
		current_speed = clamp(current_speed + acceleration * delta, 0, top_speed)
		velocity += Vector2.from_angle(direction) * sign(current_speed)
	else:
		current_speed = clamp(current_speed - acceleration * delta, 0, top_speed)
		velocity = velocity.move_toward(Vector2.ZERO, acceleration * delta)
	
	if input_vector.x > 0:
		direction += deg_to_rad(250) * delta
	elif input_vector.x < 0:
		direction -= deg_to_rad(250) * delta

	move_and_slide()
	sprite.rotation = direction + PI / 2
