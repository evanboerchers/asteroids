extends Node

@export var asteroid_scene: PackedScene
var score
var lives

func _ready():
	new_game()

func game_over() -> void:
	$AsteroidTimer.stop()
	$HUD.show_game_over()
	
func new_game() -> void:
	score = 0
	lives = 3
	$HUD.update_score(score)
	$HUD.show_game_start()
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
func _on_score_timer_timeout():
	score += 1

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
