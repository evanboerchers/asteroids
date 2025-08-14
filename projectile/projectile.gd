extends Area2D

@export var speed = 600

func _ready() -> void:
	AudioManager.play('ShipLaser')
	add_to_group('projectile')

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_body_entered(body:Node2D) -> void:
	if body.is_in_group('asteroid'):
		body.hit()
		queue_free()
