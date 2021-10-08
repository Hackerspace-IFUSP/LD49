# A code by: KeichiTS & Ícaro Freire - 2021 
extends KinematicBody2D

var GRAVITY = 2000
var MAXSPEED = 250
var JUMPFORCE = 525

var orbs : int = 0

var can_move: bool = true

var can_jump: bool = true
var pressed = false
var jumps = 1

var motion = Vector2()

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if can_move == true:
		motion.x = (Input.get_action_strength("move_right") - Input.get_action_strength("move_left")) * MAXSPEED
		motion.y += GRAVITY * delta		# Aplica gravidade
		
		#if motion.y > MAXSPEED: #não pula no ar 
		#	can_jump = false
		
		if is_on_floor(): 
			$sprites/walking.play("walking")
			can_jump = true
			pressed = false
			jumps = 1
		else: 
			$sprites/walking.play("jumping")
			
		
		if Input.is_action_just_pressed("jump") and can_jump and !pressed and jumps <= 1:
			jumps+=1
			if jumps == 1:
				can_jump = false
				pressed = true
				$coyote.start()
				
			$jump.play()
			motion.y = -JUMPFORCE


		motion = move_and_slide(motion, Vector2.UP)			# Função que faz o bixo se mover. 
		$sprites/walking.playing = motion.length() > 0
		if motion.x > 0:
			 $sprites/walking.scale.x = 1
		elif motion.x < 0:
			$sprites/walking.scale.x = -1
		if $sprites/walking.playing == false:
			 $sprites/walking.frame = 0

func play_anim_1():
	$anim.play("event")
	
func play_anim_2():
	$anim.play("event2")

###################################################
#     ~ It ain't much, but it's honest work ~     #
###################################################
##        #####################################   #
##          #############################         #
####            ######################            #
#####            #####           #                #
#######                                         ###
#########  #                                   ####
###########                              ## #######
#########      ###               ###       ########
#########     # ###             #####       #######
########      #####             ####         ######
########       ##                ##          ######
#######               ##                    #######
#######  ##           ####            ##      #####
####### #####        ########       #######    ####
########               #####                    ###
#########                                       ###
##########                                       ##
#########                                         #
###################################################
#               ~ KeichiTS - 2021 ~               #
###################################################


func _on_coyote_timeout():
	can_jump = false
	pressed = false
