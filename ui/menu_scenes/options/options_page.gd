extends Control

@export var dog: Dog

var dog_speed := 30000

var go_left: Array[DogCommand] = []
var jump_in_well: Array[DogCommand] = []
var go_to_start_pos: Array[DogCommand] = []
var go_to_heaven: Array[DogCommand] = []

@onready var main_vol_slider = $MainVolumeSlider
@onready var sfx_vol_slider = $SFXVolumeSlider
@onready var music_vol_slider = $MusicVolumeSlider


func _ready():
	go_left = DogCommandBuilder.new().go_till_hits_a_wall(dog_speed, E.FacingDirection.LEFT).build()
	main_vol_slider.value = AudioServer.get_bus_volume_db((AudioServer.get_bus_index("Master")))
	sfx_vol_slider.value = AudioServer.get_bus_volume_db((AudioServer.get_bus_index("SFX")))
	music_vol_slider.value = AudioServer.get_bus_volume_db((AudioServer.get_bus_index("Music")))
func _on_back_area_body_entered(_body):
	GameManager.go_to_scene(E.Scenes.HERO)


func _on_back_button_pressed():
	dog.append_and_execute_commands(go_left)


func _on_unlock_levels_pressed():
	for value in SceneData.scenes.values():
		var scene := value as SceneLevel
		if scene:
			scene.is_unlocked = true


func _on_main_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	if value == -40.0:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
func _on_sfx_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
	if value == -40.0:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), false)


func _on_music_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	if value == -40.0:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), false)
