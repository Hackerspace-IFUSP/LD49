# Created by Ícaro Freire on October 3rd, 2021
# https://ivfreire.github.io/gamedev.html

extends RigidBody2D

export var unstable: bool = false
onready var initial_pos = global_position
onready var init_rotation = global_rotation

func _ready():
	pass

func _physics_process(delta):
	
	$Collider.disabled = true
	var bodies = $Area2D.get_overlapping_bodies()
	if bodies:
		if bodies[0].name == 'Player':
			$Collider.disabled = false
			if self.unstable and $Timer.is_stopped(): 
				self.collapse()
	
	pass

func collapse():
	$Timer.start()
	$Collider.disabled = false
	$AnimationPlayer.play("wiggling")
	$returning_timer.start()

func _on_Timer_timeout():
	self.mode = RigidBody2D.MODE_RIGID
	#set_collision_mask_bit(0, false)
	$AnimationPlayer.stop()
	pass


func _on_returning_timer_timeout():
	modulate.a = 0
	global_position = initial_pos
	global_rotation = init_rotation
	$Collider.disabled = true 
	self.mode = RigidBody2D.MODE_STATIC
	#set_collision_mask_bit(0, true)
	$AnimationPlayer.play("desevanescence")
