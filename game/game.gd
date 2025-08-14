extends Node

@export var asteroid_scene: PackedScene

func _ready():
	new_game()

func game_over() -> void:
	$AsteroidTimer.stop()
	$HUD.show_game_over()
	await get_tree().create_timer(0.5).timeout
	AudioManager.play('GameOver')
	
func new_game() -> void:
	Global.score = 0
	Global.lives = 3
	AudioManager.play('GameStart')
	$HUD.show_game_start()
	$Player.start($StartPosition.position)
	$StartTimer.start()

func _on_start_timer_timeout():
	$AsteroidTimer.start()
	
func _on_asteroid_timer_timeout():
	var asteroid = asteroid_scene.instantiate()
	var asteroid_spawn_location = $AsteroidPath/AsteroidSpawnLocation
	asteroid_spawn_location.progress_ratio = randf()
	asteroid.position = asteroid_spawn_location.position
	var direction = asteroid_spawn_location.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4)
	asteroid.rotation = direction
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	asteroid.linear_velocity = velocity.rotated(direction)
	add_child(asteroid)


func _on_player_hit() -> void:
	if Global.lives > 1:
		$Player.respawn()
		Global.lives -= 1
	else: 
		$Player.explode()
		game_over()
