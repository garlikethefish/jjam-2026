class_name SceneData extends RefCounted

static var scenes: Dictionary[E.Scenes, Scene] = {
	E.Scenes.HERO: Scene.new("res://ui/menu_scenes/hero_page/HeroPage.tscn"),
	E.Scenes.LEVEL_SELECTION: Scene.new("res://ui/menu_scenes/level_selection/LevelSelection.tscn"),
	E.Scenes.OPTIONS: Scene.new("res://ui/menu_scenes/options/OptionsPage.tscn"),
	E.Scenes.EXTRAS: Scene.new(""),
	E.Scenes.LEVEL_1: SceneLevel.new("res://levels/TutLevel1.tscn", true, "Line"),
	E.Scenes.LEVEL_2: SceneLevel.new("res://levels/TutLevel2.tscn", false, "Snake"),
	E.Scenes.LEVEL_3: SceneLevel.new("res://levels/Level1.tscn", false, "Buttons and wires"),
	E.Scenes.LEVEL_4: SceneLevel.new("res://levels/Level2.tscn", false, "Jumper"),
	E.Scenes.LEVEL_5: SceneLevel.new("res://levels/Level3.tscn", false, "idk"),
	E.Scenes.LEVEL_6: SceneLevel.new("res://levels/Level4.tscn", false, "idk2"),
	E.Scenes.LEVEL_7: SceneLevel.new("res://levels/Level5.tscn", false, "idk3"),
	E.Scenes.LEVEL_8: SceneLevel.new("res://levels/level_7.tscn", false, "Elevator"),
}
