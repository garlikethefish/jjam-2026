extends StaticBody2D

@onready var sprite := %Sprite2D
@onready var pressed_audio_player := $AudioStreamPlayer2D

@export var one_shot_press := false
@export var interactable_to_trigger : StaticBody2D
var activated := false

func _on_detector_area_2d_body_entered(body: Node2D) -> void:
	# if player steps on button, then button is activated
	if not body.is_in_group("player") and not body.is_in_group("dog"): return
	
	pressed_audio_player.play()
	sprite.region_rect = Rect2(32.0,0.0,32.0,32.0)
	if !activated:
		if interactable_to_trigger.move == false:
			activated = true
			interactable_to_trigger.activate()
	else:
		if interactable_to_trigger.move == false and !one_shot_press:
			activated = false
			interactable_to_trigger.deactivate()


func _on_detector_area_2d_body_exited(body: Node2D) -> void:
	if (body.is_in_group("player") or body.is_in_group("dog")) and !one_shot_press:
		sprite.region_rect = Rect2(0.0,0.0,32.0,32.0)
