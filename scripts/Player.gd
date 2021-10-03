#A code by: KeichiTS - 2021 
extends KinematicBody2D


const UP = Vector2( 0, -1)
const GRAVITY = 40
const MAXSPEED = 200
const JUMPFORCE = 600

var can_jump : bool = true

var motion = Vector2()

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	
	#Aplica gravidade
	motion.y += GRAVITY^2
	
	
	#Aplica os controles de movimento horizontais 
	if Input.is_action_pressed("ui_right"):
		#$walking.play("walking")
		$walking.playing = true
		$walking.flip_h = false
	
	
		motion.x = MAXSPEED
	elif Input.is_action_pressed("ui_left"):
		#$walking.play("walking")
		$walking.playing = true
		$walking.flip_h = true
		
		motion.x = -MAXSPEED
	else: 
		$walking.playing = false
		$walking.frame = 0
		motion.x = 0 
	
	#Mecânica do pulo, precisa estar no chão para pular	
	if is_on_floor():
		$walking.play("walking")
		can_jump = true
	
	if Input.is_action_just_pressed("ui_up") and can_jump:
			motion.y = -JUMPFORCE
			$walking.play("jumping")
			$coyote.start()
				
				
	
	#Função que faz o bixo se mover. 
	motion = move_and_slide(motion,UP)


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
