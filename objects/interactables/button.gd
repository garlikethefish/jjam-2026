extends Area2D

@onready var sprite := %Sprite2D
var activated := false

func _on_body_entered(body: Node2D) -> void:
	# if player steps on button, then button is activated
	if body.is_in_group("player"):
		sprite.region_rect(32,0,32,32)
		activated = true

func activate():
	pass
