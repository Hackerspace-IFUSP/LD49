extends Node2D

export var orbs := 100




func _on_Area2D_body_entered(body):
	if body.name == "Player" and body.orbs >= orbs:
		$AnimationPlayer.play("open")
