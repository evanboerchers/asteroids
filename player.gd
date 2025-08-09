extends Area2D

signal hit

@export var speed = 400
var screen_size

func start(pos):
	position = pos
	show()
	$CollisionPolygon2D.disabled = false

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)		


func _on_body_entered(_body):
	hide()
	hit.emit()
	$CollisionPolygon2D.set_deferred("disabled", true)
