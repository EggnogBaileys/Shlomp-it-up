extends Node

@export var initial_state : gooper_state

var current_state : gooper_state
var states : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is gooper_state:
			states[child.name.to_lower()] = child
			child.changed_state.connect(on_state_changed)

	if initial_state:
		initial_state.Enter()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.Update(delta)

func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta)

func on_state_changed(state, new_state_name):
	if state != current_state:
		return 
		
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return 
		
	new_state.Enter()
	
	current_state = new_state
	
	
