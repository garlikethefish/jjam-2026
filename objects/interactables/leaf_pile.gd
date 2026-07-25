extends Area2D

@export var wooden_board : StaticBody2D
@export var button : StaticBody2D
@export var interact_key : AnimatedSprite2D
@export var hidden_interactable_type : String
@export var tilemap_to_trigger_index : int
@onready var tilemaps : Node2D
@onready var tilemap_overlay : TileMapLayer
@onready var sprite := $Sprite2D
@onready var particles := $GPUParticles2D
var player_near := false
var leaves_gone := false
var stop_interacting := false
var move := false
var new_pos
var wood_speed := 80

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interact_key.visible = false
	tilemaps = get_tree().get_first_node_in_group("tilemaps")
	tilemap_overlay = tilemaps.get_child(tilemap_to_trigger_index) # get tilemap overlay (just gotta know index from the scene
	# by default interactable hidden is wooden board
	if hidden_interactable_type == "button":
		wooden_board.queue_free()
		button.visible = true
	else:
		button.visible = false
func _physics_process(delta: float) -> void:
	if !stop_interacting:
		if Input.is_action_just_pressed("interact") and player_near:
			if !leaves_gone:
				particles.emitting = true
				sprite.visible = false
				leaves_gone = true
			else:
				if hidden_interactable_type != "button":
					new_pos = Vector2(wooden_board.position.x + 30, wooden_board.position.y)
					interact_key.visible = false
					move = true
		if move and hidden_interactable_type != "button":
			wooden_board.position = wooden_board.position.move_toward(new_pos, wood_speed * delta)
			var tween_overlay = get_tree().create_tween()
			tween_overlay.set_trans(Tween.TRANS_LINEAR)
			tween_overlay.tween_property(tilemap_overlay, "modulate", Color.TRANSPARENT, 1.1)
			
			if wooden_board.position == new_pos:
				stop_interacting = true
func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and !leaves_gone:
		interact_key.visible = true
		player_near = true

func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		interact_key.visible = false
