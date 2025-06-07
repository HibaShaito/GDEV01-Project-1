extends CharacterBody3D

var speed =10

var jump_height=30

var maxHealth=100
var health=maxHealth

var startPosition

var isAlive=true
var lives=3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Eventbus.playerHit.connect(takeDamage)
	updateUI()
	startPosition=position
	 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if(Input.is_action_pressed("move_up")):
		position.z += speed *delta
		
	if(Input.is_action_pressed("move_down")):
		position.z -= speed *delta
		
	if(Input.is_action_pressed("move_left")):
		position.x += speed *delta
		
	if(Input.is_action_pressed("move_right")):
		position.x -= speed *delta
		
	if(Input.is_action_just_pressed("jump_up")):
		position.y += jump_height *delta
		
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	fall()
		
	move_and_slide()
		
func takeDamage():
	if isAlive:
		health-=25
		print(health)
		updateUI()
		if health<=0:
			die()
		
		
func die():
	health=0
	lives-=1
	isAlive=false
	respawn()
	print("dead")
	print("lives left " + str(lives))
	
func fall():
	if position.y<-5:
		position=startPosition
		die()
	
	
func respawn():
	if lives>0:
		health=maxHealth
		isAlive=true
		position=startPosition
		updateUI()
	elif lives <=0:
		get_tree().change_scene_to_file.bind("res://Scenes/game_over.tscn").call_deferred()
		
		
	
func updateUI():
	$CanvasLayer/Control/HealthBar.value=health
	$CanvasLayer/Control/Lives.text="Lives: "+ str(lives)
