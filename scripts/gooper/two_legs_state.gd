extends gooper_state
class_name two_legs_state

# Player Base
@onready var gooper = $"../.."

# Animation Player
@export var TwoLegsAnimator : AnimationPlayer 

# Movement Speeds

@export var walking_speed := 300.0
@export var sprinting_speed := 600.0

# Jumping

@export var jump_velocity = -400.0

# Health
var current_state_health = 3


func Enter():
	SetAnimator()
	SetSpeeds()
	SetJumpPhysics()

func SetAnimator():
	gooper.currentAnimator = TwoLegsAnimator
	
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
	if gooper.health < current_state_health:
		changed_state.emit(self, "one_leg_state")



