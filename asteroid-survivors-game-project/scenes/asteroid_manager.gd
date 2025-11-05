extends Node2D

const asteroid_scene: PackedScene = preload("res://scenes/asteroid.tscn")

@onready var spawn_timer: Timer = $spawn_timer

var spawn_offset: float = 460
@export var spawn_angle_spread: float = 1.0

func _ready() -> void:
	spawn_timer.timeout.connect(spawn_asteroid)

func spawn_asteroid():
	var center: Vector2 = get_viewport_rect().size / 2
	var spawn_point: Vector2 = center + (Vector2.from_angle(randf() * TAU).normalized()) * spawn_offset
	var asteroid: Asteroid = asteroid_scene.instantiate()
	asteroid.global_position = spawn_point
	asteroid.velocity = Vector2.from_angle((center - spawn_point).angle() + randf_range(-spawn_angle_spread, spawn_angle_spread)) * 100
	get_tree().root.add_child(asteroid)
