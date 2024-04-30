extends gooper_state
class_name no_legs_state

# Player Base
@onready var gooper = $"../.."

# Animation Player
@export var NoLegsAnimator : AnimationPlayer 

# Movement Speeds
@export var walking_speed := 400.0
@export var sprinting_speed := 0.0

# Jumping
@export var jump_velocity = -600.0

# Health
var current_state_health = 1

func Enter():
	SetAnimator()
	SetSpeeds()
	SetJumpPhysics()
	

func SetAnimator():
	gooper.currentAnimator = NoLegsAnimator

func SetSpeeds():
	gooper.walking_speed = walking_speed
	gooper.sprinting_speed = sprinting_speed

func SetJumpPhysics():
	gooper.jump_velocity = jump_velocity


func Update(delta):
	if gooper.health != current_state_health:
		Exit()


func Exit():
	gooper.reset_animator()
	if gooper.health > current_state_health:
		changed_state.emit(self, "one_leg_state")
