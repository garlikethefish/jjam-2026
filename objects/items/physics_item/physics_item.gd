extends RigidBody2D

class_name PhysicsItem

@export var item: Item
@onready var sprite := $Sprite2D

func _ready() -> void:
	if item != null:
		sprite.texture = item.texture


func collect() -> Item:
	return item
