extends RigidBody2D

signal hit

@export var thrust      := 1200.0
@export var turn_torque := 9000.0 
@export var max_speed   := 900.0  
@export var lin_damp    := 2.0    
@export var ang_damp    := 2      

var screen_size: Vector2

func start(pos: Vector2) -> void:
	position = pos
	show()
	$Hitbox.disabled = false

func _ready() -> void:
	screen_size = get_viewport_rect().size
	linear_damp = lin_damp
	angular_damp = ang_damp
	$Thrust.visible = false

func _physics_process(_delta: float) -> void:
	var rot_dir := 0.0
	if Input.is_action_pressed("move_right"):
		rot_dir += 1.0
	if Input.is_action_pressed("move_left"):
		rot_dir -= 1.0
	apply_torque( rot_dir * turn_torque) 

	if Input.is_action_pressed("move_up"):
		var forward := Vector2.UP.rotated(rotation)
		apply_force(forward * thrust) 
		$Thrust.visible = true
	else:
		$Thrust.visible = false

	var speed := linear_velocity.length()
	if speed > max_speed:
		linear_velocity = linear_velocity.normalized() * max_speed

	_wrap_to_screen()

func _wrap_to_screen() -> void:
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)

func _on_body_entered(_body: Node) -> void:
	hide()
	hit.emit()
	$Hitbox.set_deferred("disabled", true)
