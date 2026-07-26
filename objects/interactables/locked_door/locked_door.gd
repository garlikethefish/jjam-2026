extends StaticBody2D

@export var required_item: Item

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is not Dog: return
	
	print("dog entered")
	
	var dog = body as Dog
	if dog.carried_item.name == required_item.name:
		dog.discard_item()
		open()


func open():
	queue_free()
