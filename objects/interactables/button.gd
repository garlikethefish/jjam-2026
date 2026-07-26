extends StaticBody2D

enum SpriteVariations {
	Activated = 0,
	Deactivated = 1
}

@onready var sprite_atlas := %Sprite2D
@onready var pressed_audio_player := $AudioStreamPlayer2D

@export var one_shot_press := false
@export var interactables_to_trigger : Array[StaticBody2D] = []
var activated := false


func _on_detector_area_2d_body_entered(body: Node2D) -> void:
	# if player steps on button, then button is activated
	if (
		not body.is_in_group("player") 
		and not body.is_in_group("dog") 
		or interactables_to_trigger.size() <= 0
	): return
	
	for interactable in interactables_to_trigger:
		if !interactable.finished_action: return
		
	pressed_audio_player.play()
	select_sprite_variation(SpriteVariations.Activated)	
	activated = !activated
	
	if activated:
		for interactable in interactables_to_trigger:
			interactable.activate()
			
	else:
		if one_shot_press: return
		
		for interactable in interactables_to_trigger:
			interactable.deactivate()


func _on_detector_area_2d_body_exited(body: Node2D) -> void:
	if (body.is_in_group("player") or body.is_in_group("dog")) and !one_shot_press:
		select_sprite_variation(SpriteVariations.Deactivated)


func select_sprite_variation(variant: SpriteVariations):
	sprite_atlas.region_rect = Rect2(32.0 * variant,0.0,32.0,32.0)
