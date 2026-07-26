extends Node2D

class_name Hole

@export var output_hole: Hole


func _on_area_2d_body_entered(body: Node2D) -> void:
	if output_hole == null: return
	if body == null: return
	
	print("tp enter: ", body.name)
	
	if body is RigidBody2D:
		PhysicsServer2D.body_set_state(
			body.get_rid(),
			PhysicsServer2D.BODY_STATE_TRANSFORM,
			Transform2D(body.global_rotation, output_hole.global_position)
		)
		PhysicsServer2D.body_set_state(
			body.get_rid(),
			PhysicsServer2D.BODY_STATE_LINEAR_VELOCITY,
			Vector2.ZERO
		)
	else:
		body.global_position = output_hole.global_position
