extends Node

var executed_command_count = 0
var command_stack: Array[DogCommand] = []
var level_timeline := Timeline.new()

var level_scenes: Dictionary[String, String]= {
	"Level1": "res://levels/Level1.tscn",
	#"Level2": preload(),
	"Level3": "res://levels/Level3.tscn",
	"Level4": "res://levels/Level4.tscn",
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
	

func go_to_scene(scene_name: String):
	await TransitionScreen.close().finished
	get_tree().change_scene_to_file(GameManager.level_scenes[scene_name])
	await TransitionScreen.open().finished
