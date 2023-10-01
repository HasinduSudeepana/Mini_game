tool
extends Button

export(String, FILE)  var next_scene_path: = ""

func _on_button_up():
	get_tree().change_scene(next_scene_path)

func _get_configuration_warning() -> String:
	return "next scene_path must be set for the button to work" if not next_scene_path == "" else ""
"res://src/Screens/MainScreen.tscn"
