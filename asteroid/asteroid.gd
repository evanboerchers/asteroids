extends RigidBody2D

func _ready() -> void:
	add_to_group('asteroid')

func hit() -> void:
	call_deferred("queue_free")
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	call_deferred("queue_free")

