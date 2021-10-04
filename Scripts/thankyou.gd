extends Control

func _ready():
	$anim.play("event")
	#yield($anim,"animation_finished")


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Title_screen.tscn")


func black_screen_del():
	$black_screen.queue_free()
