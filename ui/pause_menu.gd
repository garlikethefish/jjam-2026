extends CanvasLayer
var already_paused := false

@onready var main_vol_slider = $Panel/SFXVolumeSlider
@onready var sfx_vol_slider = $Panel/MainVolumeSlider
@onready var music_vol_slider = $Panel/MusicVolumeSlider

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("trigger_pausemenu", control_pausemenu)
	
	main_vol_slider.value = AudioServer.get_bus_volume_db((AudioServer.get_bus_index("Master")))
	sfx_vol_slider.value = AudioServer.get_bus_volume_db((AudioServer.get_bus_index("SFX")))
	music_vol_slider.value = AudioServer.get_bus_volume_db((AudioServer.get_bus_index("Music")))


func control_pausemenu():
	if already_paused == false:
		print('happeing')
		self.visible = true
		already_paused = true
		get_tree().paused = true
	else:
		self.visible = false
		already_paused = false
		get_tree().paused = false


func _on_back_button_pressed() -> void:
	self.visible = false
	already_paused = false
	get_tree().paused = false


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
