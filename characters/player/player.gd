extends CharacterBody2D


@export var regular_speed = 100.0
@export var jump_velocity = -400.0
@export var sprint_speed := 200.0
@export var disable_movement := false
@onready var sprite := $AnimatedSprite2D
@onready var anim_player := $AnimationPlayer


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		anim_player.play("run")
		velocity += get_gravity() * delta
		
	if disable_movement: return

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		if direction < 0.0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
		if Input.is_action_pressed("sprint"):
			velocity.x = direction * sprint_speed
		else:
			if is_on_floor():
				anim_player.play("run")
			velocity.x = direction * regular_speed
	else:
		if is_on_floor():
			anim_player.play("idle")
		velocity.x = move_toward(velocity.x, 0, regular_speed)

	move_and_slide()
