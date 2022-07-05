extends KinematicBody2D
#here 
var velocity = Vector2(0,0);
var gravity = 2000;
var score = 0;

func score_count(): 
	score = score + 1;
	print('score so far: ', score);

#using animationPlayer instead of animatedSprite
onready var _animation_player = $AnimationPlayer
onready var _sprite = $Sprite

func _process(delta): 
	if Input.is_action_just_pressed("jump")and is_on_floor():
		velocity.y  = -800
		_animation_player.play('jump');
	#$AnimatedSprite.play('jump');
	if Input.is_action_pressed("left_arrow"):
		velocity.x = -300
		_animation_player.play('run');
		_sprite.flip_h = true;
	#$AnimatedSprite.play("run")
	#$AnimatedSprite.flip_h = true
	elif Input.is_action_pressed("right_arrow"):
		velocity.x = 300
		_animation_player.play('run');
		_sprite.flip_h = false;		
		#$AnimatedSprite.play("run");
		#$AnimatedSprite.flip_h = false
	#else: $AnimatedSprite.play('idle');
	else: _animation_player.play('idle')
	# if player is on the air -> always play 'jump'
	if not is_on_floor(): 
		_animation_player.play("jump");
		#$AnimatedSprite.play('jump')
	
func _physics_process(_delta):
# if 'jump' pressed and player is on the floor -> make gravity opposite AND play animation	
#move_and_slide is godot function
#lerp for smoothly stop
# _delta ensures that the game’s behavior stays consistent even if the FPS changes.
	velocity.y = velocity.y  + (gravity) * (_delta);
	move_and_slide(velocity, Vector2.UP);
	velocity.x = lerp(velocity.x,0,0.1);
	
