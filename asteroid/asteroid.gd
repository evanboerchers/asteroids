extends RigidBody2D

func _ready() -> void:
	add_to_group('asteroid')

func hit() -> void:
	queue_free()
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body: Node) -> void:
	hit()
	body.queue_free()
