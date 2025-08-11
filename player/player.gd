extends RigidBody2D

signal hit
@export var Projectile: PackedScene

@export var thrust      := 9000.0
@export var turn_torque := 4000.0 
@export var max_speed   := 900.0  
@export var lin_damp    := 2.0    
@export var ang_damp    := 2      
@export var invul_dur   := 2

var screen_size: Vector2
var isInvulnerable = false;

func start(pos: Vector2) -> void:
	position = pos
	show()
	$Hitbox.disabled = false
	
func respawn(pos: Vector2) -> void:
	position = pos
	show()
	invulnerable()

func invulnerable() -> void:
	isInvulnerable = true
	$Hitbox.disabled = true
	call_deferred('flash')
	await get_tree().create_timer(invul_dur).timeout
	$Hitbox.disabled = false
	isInvulnerable = false
	visible = true
	
func flash() -> void:
	while isInvulnerable:
		visible = !visible
		await get_tree().create_timer(0.15).timeout
	visible = true


func shoot():
	var p = Projectile.instantiate()
	if(owner):
		owner.add_child(p)
		p.transform = $Cannon.global_transform
		p.rotate(-PI/2)
	else:
		add_child(p)

func _ready() -> void:
	_set_properties()   
	$Thrust.visible = false

func _set_properties() -> void:
	screen_size = get_viewport_rect().size
	linear_damp = lin_damp
	angular_damp = ang_damp

func _physics_process(delta: float) -> void:
	_apply_rotation()
	_apply_thrust()
	_wrap_to_screen()
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _apply_rotation():
	var rot_dir := 0.0
	if Input.is_action_pressed("move_right"):
		rot_dir += 1.0
	if Input.is_action_pressed("move_left"):
		rot_dir -= 1.0
	apply_torque( rot_dir * turn_torque) 

func _apply_thrust():
	if Input.is_action_pressed("move_up"):
		var forward := Vector2.UP.rotated(rotation)
		apply_force(forward * thrust) 
		$Thrust.visible = true
	else:
		$Thrust.visible = false
	var speed := linear_velocity.length()
	if speed > max_speed:
		linear_velocity = linear_velocity.normalized() * max_speed

func _wrap_to_screen() -> void:
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)

func _on_body_entered(_body: Node) -> void:
	hide()
	hit.emit()
	$Hitbox.set_deferred("disabled", true)
