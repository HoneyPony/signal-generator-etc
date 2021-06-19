extends Control

func _on_ColorRect_mouse_entered():
	GS.ui_capture_mouse = true


func _on_ColorRect_mouse_exited():
	GS.ui_capture_mouse = false
