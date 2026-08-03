extends CharacterBody2D

class_name Dog

signal finished_commands

@export var SPEED = 600.0
@export var air_drag = .9
@export var ground_drag = .9
@export_category("Jump")
@export var JUMP_VELOCITY = 300.0
@export var max_jump_duration = .3
@export var x_force = 100
@export_category("Other")
@export var disable_movement := false

@onready var anim_player := $AnimationPlayer
var cur_jump_duration = .3

@export var carried_item: Item

@onready var right_cast_2d: ShapeCast2D = $RightShapeCast2D
@onready var left_cast_2d: ShapeCast2D = $LeftShapeCast2D2
@onready var sprite := $Sprite2D
@onready var item_sprite := $ItemSprite2D
@onready var footstep_player: AudioStreamPlayer2D = $FootstepPlayer2D

var current_command: DogCommand = null

var is_executing_command := false

var item_sprite_origin_local_pos := Vector2.ZERO
#get: return is_going_right or is_going_left or is_jumping
var is_going_right = false
var is_going_left = false
var is_jumping = false
var is_just_started_executing_command := false
var current_timeline_action: TimelineAction
var facing_direction := Enums.FacingDirection.RIGHT

var save_gap_delay = .01
var cur_save_gap_delay = save_gap_delay


func _ready() -> void:
	item_sprite_origin_local_pos = item_sprite.position


func _physics_process(delta: float) -> void:
	# update curent command
	if current_command != null:
		current_command.physics_process(delta)

	handle_facing_position()

	if disable_movement:
		if not is_on_floor():
			velocity += get_gravity() * delta

		return

	#is_executing_command.set_value(is_going_left or is_going_right or is_jumping)

	## creating timeline action
	#if is_executing_command.just_true():
	#current_timeline_action = TimelineAction.new()
	#footstep_player.stream_paused = false
	#anim_player.play("run")
	#
	#if is_executing_command.just_false():
	#GameManager.level_timeline.add_action(current_timeline_action)
	#current_timeline_action = null
	#footstep_player.stream_paused = true
	#anim_player.play("idle")
	#
	#if is_executing_command.is_true() and current_timeline_action != null:
	#current_timeline_action.phisics_add_point(TimelineActionPoint.new(self), delta)

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_on_floor():
		velocity = velocity * ground_drag
	else:
		velocity = velocity * air_drag

	# drag
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is PhysicsItem and carried_item == null:
		carried_item = (body as PhysicsItem).collect()
		item_sprite.texture = carried_item.texture
		print("collected")


func handle_facing_position():
	if facing_direction == Enums.FacingDirection.RIGHT:
		# is looking RIGHT
		sprite.flip_h = false
		item_sprite.position = item_sprite_origin_local_pos
	elif facing_direction == Enums.FacingDirection.LEFT:
		# is looking LEFT
		sprite.flip_h = true
		item_sprite.position = -item_sprite_origin_local_pos


func discard_item():
	carried_item = null
	item_sprite.texture = null


func execute_commands(commands: Array[DogCommand]):
	if is_executing_command:
		return

	is_executing_command = true

	for command in commands:
		current_command = command
		current_command.execute()
		await current_command.finished

	finished_commands.emit()
	is_executing_command = false
