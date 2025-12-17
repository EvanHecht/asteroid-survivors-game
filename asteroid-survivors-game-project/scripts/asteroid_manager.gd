extends Node2D

const asteroid_scene: PackedScene = preload("res://scenes/asteroid.tscn")

@onready var spawn_timer: Timer = %SpawnTimer

var spawn_offset: float = 460
var wave_budget: int = 100
var min_budget_for_group: int = 25
var current_wave = 1
var max_modifiers = 1
var modifier_chance_increase_per_wave = 0.1

@export var spawn_angle_spread: float = 1.0

func _ready() -> void:
	spawn_timer.timeout.connect(start_wave)

func start_wave():
	while (wave_budget >= min_budget_for_group):
		spawn_asteroid()

func spawn_asteroid():
	var center: Vector2 = get_viewport_rect().size / 2
	var spawn_point: Vector2 = center + (Vector2.from_angle(randf() * TAU).normalized()) * spawn_offset
	var asteroid: Asteroid = asteroid_scene.instantiate()
	asteroid.global_position = spawn_point
	asteroid.velocity = Vector2.from_angle((center - spawn_point).angle() + randf_range(-spawn_angle_spread, spawn_angle_spread)) * randi_range(15, 30)
	get_tree().root.add_child(asteroid)
	wave_budget -= Asteroid.cost
