extends Node

@export var asteroid_scene: PackedScene
var score

func _ready():
	new_game()

func game_over() -> void:
	$AsteroidTimer.stop()

func new_game() -> void:
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
func _on_score_timer_timeout():
	score += 1

func _on_start_timer_timeout():
	$AsteroidTimer.start()
	
func _on_asteroid_timer_timeout():
	# Create a new instance of the Mob scene.
	var asteroid = asteroid_scene.instantiate()

	# Choose a random location on Path2D.
	var asteroid_spawn_location = $AsteroidPath/AsteroidSpawnLocation
	asteroid_spawn_location.progress_ratio = randf()

	# Set the mob's position to the random location.
	asteroid.position = asteroid_spawn_location.position

	# Set the mob's direction perpendicular to the path direction.
	var direction = asteroid_spawn_location.rotation + PI / 2

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	asteroid.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	asteroid.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(asteroid)
