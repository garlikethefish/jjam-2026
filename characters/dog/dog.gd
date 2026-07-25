extends CharacterBody2D

class_name Dog

@export var SPEED = 600.0
@export var JUMP_VELOCITY = -400.0
@export var air_drag = .9
@export var ground_drag = .9
@export var max_jump_duration = .3
var cur_jump_duration = .3

@onready var right_cast_2d: RayCast2D = $RightCast
@onready var left_cast_2d: RayCast2D = $LeftCast2
@onready var sprite := $Sprite2D

enum FacingDirections {
	Right = 1,
	Left = -1
}

var is_executing_command:
	get: return is_going_right or is_going_left or is_jumping
var is_going_right = false
var is_going_left = false
var is_jumping = false
var facing_direction := FacingDirections.Right

var save_gap_delay = .05
var cur_save_gap_delay = save_gap_delay

func _physics_process(delta: float) -> void:
	
	if is_executing_command:
		# saving itself in timeline
		if cur_save_gap_delay == 0:
			GameManager.level_timeline.add_point(TimelinePoint.new(self))
			cur_save_gap_delay = save_gap_delay
			print("added point")
		else:
			cur_save_gap_delay = clamp(cur_save_gap_delay - delta, 0, save_gap_delay)
	
	if facing_direction == FacingDirections.Right:
		sprite.flip_h = false
	else:
		sprite.flip_h = true

	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		

	# go right
	if is_going_right:
		velocity += Vector2.RIGHT * SPEED * delta
		
		if right_cast_2d.is_colliding():
			is_going_right = false
			velocity = Vector2.ZERO
	
	# go left
	if is_going_left:
		velocity += Vector2.LEFT * SPEED * delta
		
		if left_cast_2d.is_colliding():
			is_going_left = false
			velocity = Vector2.ZERO
	
	
			
	# drag
	if is_on_floor():
		velocity = velocity * ground_drag
	else:
		velocity = velocity * air_drag
	
	if is_jumping:
		if cur_jump_duration == max_jump_duration:
			velocity.y = JUMP_VELOCITY
			
		velocity.x = 100 * facing_direction 
		cur_jump_duration = clamp(cur_jump_duration - delta, 0, max_jump_duration)
		
		if cur_jump_duration == 0:
			is_jumping = false
		

	move_and_slide()


func go_left():
	is_going_left = true
	facing_direction = FacingDirections.Left



func go_right():
	is_going_right = true
	facing_direction = FacingDirections.Right


func go_down():
	pass


func jump():
	if is_on_floor():
		is_jumping = true
		cur_jump_duration = max_jump_duration


func interact():
	pass
