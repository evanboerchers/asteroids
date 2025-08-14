extends RigidBody2D

@export var points_value := 100

func _ready() -> void:
	add_to_group('asteroid')

func hit() -> void:
	AudioManager.play('RockBreak')
	Global.score += points_value
	call_deferred("queue_free")
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	call_deferred("queue_free")
