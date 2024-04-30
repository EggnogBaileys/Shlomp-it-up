extends CharacterBody2D

# Movement Speeds

@export var walking_speed : float
@export var sprinting_speed : float
var current_speed : float

# Jumping

@export var jump_velocity : float
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Health
@export var health := 3

# in the case of cutscenes, to stop him from goin' all shlompers on us if u know what i mean
@export var canMove := true

var currentAnimator



func _ready():
	current_speed = walking_speed
	currentAnimator.play("Idle")



func _physics_process(delta):

	manage_gravity(delta)
	
	manage_speed()

	jump()

	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * current_speed
	else:
		if is_on_floor():
			currentAnimator.play("Idle")
		velocity.x = move_toward(velocity.x, 0, current_speed)

	flip_sprite(velocity.x)

	move_and_slide()
	
	if Input.is_action_just_released("Kick"):
		if health > 1:
			health -= 1
		
	elif Input.is_action_just_pressed("RightClick"):
		if health < 3:
			health += 1


func manage_speed():
	if Input.is_action_pressed("Sprint"):
		current_speed = sprinting_speed
	else: 
		current_speed = walking_speed


func manage_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta


func jump():
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_velocity


func flip_sprite(horizontal_velocity):
	
	if horizontal_velocity > 0:
		$GooperSprite.flip_h = false 
	elif horizontal_velocity < 0:
		$GooperSprite.flip_h = true


func reset_animator():
	currentAnimator.play("RESET")



# Gooper's hitbox
func _on_area_2d_area_entered(area):
	if area.is_in_group("hazard"):
		health -= 1
		
