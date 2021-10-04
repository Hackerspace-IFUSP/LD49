extends Node2D

var colected : bool = false

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		if !colected:
			colected = true
			body.orbs += 1
			get_tree().call_group("hud", "update_hud", body.orbs)
			get_parent().get_parent().get_parent().timer -= 2
		$AnimationPlayer.play("collect")
		
