# Created by Ícaro Freire on October 3rd, 2021
# https://ivfreire.github.io/gamedev.html

extends RigidBody2D

export var unstable: bool = false

func _ready():
	pass

func _physics_process(delta):
	
	$Collider.disabled = true
	var bodies = $Area2D.get_overlapping_bodies()
	if bodies:
		if bodies[0].name == 'Player':
			$Collider.disabled = false
			if self.unstable and $Timer.is_stopped(): self.collapse()
	
	pass

func collapse():
	$Timer.start()
	$Collider.disabled = false
	$AnimationPlayer.play("wiggling")
	pass


func _on_Timer_timeout():
	self.mode = RigidBody2D.MODE_RIGID
	pass
