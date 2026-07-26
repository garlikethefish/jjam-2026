extends Node

var executed_command_count = 0
var command_stack: Array[DogCommand] = []
var level_timeline := Timeline.new()

var level_scenes: Dictionary[String, Resource]= {
	"Level1": preload("res://levels/gar_testing_ground.tscn"),
	#"Level2": preload(),
	#"Level3": preload(),
	#"Level4": preload(),
	#"Level5": preload(),
	#"HeroScene": preload()
	"LevelSelection": preload("res://ui/menu_scenes/LevelSelection.tscn")
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	level_timeline.process(delta)
