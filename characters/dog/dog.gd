extends CharacterBody2D

class_name Dog

@export var SPEED = 600.0
@export var JUMP_VELOCITY = -400.0
@export var air_drag = .9
@export var ground_drag = .9
@export var max_jump_duration = .3
@onready var anim_player := $AnimationPlayer
var cur_jump_duration = .3

@export var carried_item: Item

@onready var right_cast_2d: RayCast2D = $RightCast
@onready var left_cast_2d: RayCast2D = $LeftCast2
@onready var sprite := $Sprite2D
@onready var item_sprite := $ItemSprite2D
@onready var footstep_player: AudioStreamPlayer2D = $FootstepPlayer2D

enum FacingDirections {
	Right = 1,
	Left = -1
}

var is_executing_command := OneValueBoolBuffer.new(false)

var item_sprite_origin_local_pos := Vector2.ZERO
	#get: return is_going_right or is_going_left or is_jumping
var is_going_right = false
var is_going_left = false
var is_jumping = false
var is_just_started_executing_command := false
var current_timeline_action: TimelineAction
var facing_direction := FacingDirections.Right

var save_gap_delay = .01
var cur_save_gap_delay = save_gap_delay

func _ready() -> void:
	item_sprite_origin_local_pos = item_sprite.position


func _physics_process(delta: float) -> void:
	is_executing_command.set_value(is_going_left or is_going_right or is_jumping)
	
	# creating timeline action
	if is_executing_command.just_true():
		current_timeline_action = TimelineAction.new()
		footstep_player.stream_paused = false
		anim_player.play("run")
		
		
	if is_executing_command.just_false():
		GameManager.level_timeline.add_action(current_timeline_action)
		current_timeline_action = null
		footstep_player.stream_paused = true
		anim_player.play("idle")
	
	if is_executing_command.is_true() and current_timeline_action != null:
		current_timeline_action.phisics_add_point(TimelineActionPoint.new(self), delta)
		
	
	if facing_direction == FacingDirections.Right:
		# is looking right
		sprite.flip_h = false
		item_sprite.position = item_sprite_origin_local_pos
	else:
		# is looking left
		sprite.flip_h = true
		item_sprite.position = -item_sprite_origin_local_pos

	
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
	
	# is jumping
	if is_jumping:
		if cur_jump_duration == max_jump_duration:
			velocity.y = JUMP_VELOCITY
		
		cur_jump_duration = clamp(cur_jump_duration - delta, 0, max_jump_duration)
		
		if cur_jump_duration != 0:
			velocity.x = 100 * facing_direction 
			
		if cur_jump_duration == 0 and is_on_floor():
			is_jumping = false
		

	move_and_slide()


func go_left():
	is_going_left = true
	facing_direction = FacingDirections.Left
	is_just_started_executing_command = true


func go_right():
	is_going_right = true
	facing_direction = FacingDirections.Right
	is_just_started_executing_command = true


func go_down():
	is_just_started_executing_command = true
	pass
	


func jump():
	if !is_on_floor(): return
	
	is_jumping = true
	cur_jump_duration = max_jump_duration
	is_just_started_executing_command = true
	


func interact():
	pass


func discard_item():
	carried_item = null
	item_sprite.texture = null


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is PhysicsItem and carried_item == null:
		carried_item = (body as PhysicsItem).collect()
		item_sprite.texture = carried_item.texture
		print("collected")
