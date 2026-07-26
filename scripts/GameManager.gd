extends Node

var executed_command_count = 0
var command_stack: Array[DogCommand] = []
var level_timeline := Timeline.new()

var level_scenes: Dictionary[String, String]= {
	"Level1": "res://levels/gar_testing_ground.tscn",
	#"Level2": preload(),
	"Level3": "res://levels/Level3.tscn",
	"Level4": "res://levels/level_4.tscn",
	#"Level5": preload(),
	"HeroScene": "res://ui/menu_scenes/hero_page/HeroPage.tscn",
	"LevelSelection": "res://ui/menu_scenes/level_selection/LevelSelection.tscn"
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	level_timeline.process(delta)
