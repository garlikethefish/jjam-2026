extends Area2D

@export var tilemaps: Array[TileMapLayer] = []
@export var interact_key: AnimatedSprite2D
@export var add_plank := true

@onready var bush_sprite := $Sprite2D
@onready var particles := $GPUParticles2D
@onready var wooden_board := $WoodenBoard

var player_near := false
var is_bush_destroyed := false
var is_board_moved := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interact_key.visible = false
	
	if !add_plank:
		wooden_board.visible = false
		wooden_board.queue_free()

func _physics_process(_delta: float) -> void:
	if is_board_moved: return
	if Input.is_action_just_pressed("interact") and player_near:
		
		if is_bush_destroyed and add_plank:
			interact_key.visible = false
			
			# early kill if empty
			if tilemaps.size() <= 0:
				#queue_free()
				return
				
			var tween = get_tree().create_tween().set_parallel(true).set_trans(Tween.TRANS_LINEAR)
			
			# fade tilemap
			for tilemap in tilemaps:
				tween.tween_property(tilemap, "modulate", Color.TRANSPARENT, 0.7)
				
			# move board
			tween = get_tree().create_tween().set_parallel(true).set_trans(Tween.TRANS_LINEAR)
			
			var board_start_pos = wooden_board.position
			tween.tween_property(wooden_board, "position", board_start_pos + Vector2(35, 0), 0.7)
			
			await tween.finished
			is_board_moved = true
			
			
			
			await get_tree().create_timer(1.2).timeout

		
		if !is_bush_destroyed:
			particles.emitting = true
			
			if !add_plank:
				is_board_moved = true
				interact_key.visible = false
			
			var tween = get_tree().create_tween().set_parallel(true)
			tween.set_trans(Tween.TRANS_LINEAR)
			
			tween.tween_property(bush_sprite, "modulate", Color.TRANSPARENT, 1.1)
			is_bush_destroyed = true


func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and !is_board_moved:
		interact_key.visible = true
		player_near = true


func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player") and !is_board_moved:
		interact_key.visible = false
		player_near = false
