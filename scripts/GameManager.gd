extends Node

var executed_command_count = 0
var command_stack: Array[DogCommand] = []
var level_timeline := Timeline.new()
var current_scene_name := E.Scenes.HERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	level_timeline.process(delta)


func go_to_scene(scene: E.Scenes):
	await TransitionScreen.close().finished
	#current_scene_name = E.Scenes.keys()[scene]
	get_tree().change_scene_to_file(SceneData.scenes[scene].path)
	await TransitionScreen.open().finished
	executed_command_count = 0
