class_name Asteroid
extends Node2D

@onready var sprite: Sprite2D = %Sprite
var velocity: Vector2 = Vector2.ZERO
var size: int = 3

const cost: int = 5

func _ready() -> void:
	sprite.rotation = velocity.angle()
	print("asteroid created")

func _process(delta: float) -> void:
	position += velocity * delta
