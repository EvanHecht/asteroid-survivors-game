class_name Player
extends CharacterBody2D

const bullet_scene: PackedScene = preload("res://scenes/bullet.tscn")

@onready var sprite: Sprite2D = $sprite

@export var top_speed = 20
var current_speed = 0
var acceleration = 15
var direction = 0

func  _draw() -> void:
	draw_line(Vector2.ZERO, velocity, Color.RED, 5)
	
func _ready() -> void:
	wall_min_slide_angle = 0

func _physics_process(delta: float) -> void:
	var input_vector = Input.get_vector("move_left", "move_right", "move_down", "accelerate")
	if input_vector.y > 0:
		current_speed = clamp(current_speed + acceleration * delta, 0, top_speed)
		velocity += Vector2.from_angle(direction) * sign(current_speed)
	else:
		current_speed = clamp(current_speed - acceleration * delta, 0, top_speed)
		velocity = velocity.move_toward(Vector2.ZERO, acceleration * delta)
	
	if abs(input_vector.x) > 0.1:
		direction += deg_to_rad(input_vector.x * 250) * delta
		
	move_and_slide()
	# position = position.clamp(Vector2.ZERO, get_viewport_rect().size)
	if is_on_wall():
		var collision = get_last_slide_collision()
		var directionVector: Vector2 = collision.get_position() - position
		if abs(directionVector.x) > abs(directionVector.y):
			velocity = Vector2(0, velocity.y)
		else:
			velocity = Vector2(velocity.x, 0)

	sprite.rotation = direction + PI / 2
	queue_redraw()

	if Input.is_action_pressed("shoot"):
		var bullet: Bullet = bullet_scene.instantiate()
		bullet.position = position
		bullet.velocity = Vector2.from_angle(direction) * 750
		get_tree().root.add_child(bullet)
		# BIG POWER BELOW
		#var shot_angles = range(0, 360, 10)
		#for i in shot_angles:
			#var new_bullet: Bullet = bullet_scene.instantiate()
			#new_bullet.position = position
			#new_bullet.velocity = Vector2.from_angle(deg_to_rad(i)) * 750
			#get_tree().root.add_child(new_bullet)
