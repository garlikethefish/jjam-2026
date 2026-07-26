extends StaticBody2D

@export var sprite_variant: int = 0
@export var required_item: Item
@onready var sprite_variations: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	select_sprite_variation(sprite_variant)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is not Dog: return
	
	print("dog entered")
	
	var dog = body as Dog
	if dog.carried_item.name == required_item.name:
		dog.discard_item()
		open()


func open():
	queue_free()
	

func select_sprite_variation(val: int):
	sprite_variations.region_rect = Rect2(32.0 * val,0.0,32.0,32.0)
	
