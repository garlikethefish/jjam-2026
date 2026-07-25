extends RigidBody2D

class_name PhysicsItem

@export var item: Item
@onready var sprite := $Sprite2D
var is_collected := false

func _ready() -> void:
	if item != null:
		sprite.texture = item.texture


func _process(_delta: float) -> void:
	if is_collected: queue_free()


func collect() -> Item:
	is_collected = true
	return item
