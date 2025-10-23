class_name Bullet
extends Node2D

@onready var sprite: Sprite2D = $Sprite2D
var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	sprite.rotation = velocity.angle()

func _process(delta: float) -> void:
	position += velocity * delta
