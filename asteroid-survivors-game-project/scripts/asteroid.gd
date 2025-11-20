class_name Asteroid
extends Node2D

@onready var sprite: Sprite2D = $Sprite2D
var velocity: Vector2 = Vector2.ZERO
var size: int = 3
var reinforced: bool = false
var exploder: bool = false

enum MODIFIERS {
	REINFORCED,
	EXPLODER
}

var modifier_values: Dictionary[MODIFIERS, bool] = {
	MODIFIERS.REINFORCED : false,
	MODIFIERS.EXPLODER : false
}

const cost: int = 5

func _ready() -> void:
	sprite.rotation = velocity.angle()
	print("asteroid created")

func _process(delta: float) -> void:
	position += velocity * delta

func apply_modifier():
	var modifier_keys = modifier_values.keys()
	var apply_index = modifier_keys.pick_random()
	var init_apply_index = apply_index
	while (modifier_values[apply_index]):
		apply_index = (apply_index + 1) % modifier_keys.size()
		if (apply_index == init_apply_index):
			break
	modifier_values[apply_index] = true
