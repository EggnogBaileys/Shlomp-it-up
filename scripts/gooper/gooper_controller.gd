extends CharacterBody2D

# Movement Speeds

@export var walking_speed := 300.0
@export var sprinting_speed := 600.0
var current_speed : float

# Jumping

@export var jump_velocity = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Health
# we can repurpose this to be used for the state machine to determine his behaviours
@export var health := 3


# in the case of cutscenes, to stop him from goin' all shlompers on us if u know what i mean
@export var canMove := true


func _ready():
	current_speed = walking_speed



func _physics_process(delta):

	manage_gravity(delta)
	
	manage_speed()

	jump()

	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)

	move_and_slide()


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







# Gooper's hitbox
func _on_area_2d_area_entered(area):
	if area.is_in_group("hazard"):
		health -= 1
		
