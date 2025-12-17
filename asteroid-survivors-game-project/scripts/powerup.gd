class_name Powerup
extends Node2D

const RADIUS: float = 10.0

@onready var collision_area: Area2D = %CollisionArea


func _ready() -> void:
	collision_area.body_entered.connect(on_body_entered)
	

func on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("detected player")
		apply_powerup(body as Player)
		queue_free()


func _draw() -> void:
	draw_circle(Vector2.ZERO, RADIUS, Color.WHITE)


func apply_powerup(player: Player) -> void:
	player.fire_rate *= 0.5
