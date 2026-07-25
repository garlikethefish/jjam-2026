extends Node2D
@export
var animation_player:AnimationPlayer
var has_played:bool=false
@export var audiostream_player:AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if has_played==false:
		has_played=true	
	animation_player.play("fall")
	audiostream_player.play()
