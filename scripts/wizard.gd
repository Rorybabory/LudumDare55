extends CharacterBody2D

const SPEED = 50

var runTimer = 0.0;

var fireCount = 0.0
var firing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	runTimer += delta
	var axisX = Input.get_axis("left", "right");
	var axisY = Input.get_axis("up", "down");
	var moveVector = Vector2(axisX, axisY).normalized()
	self.velocity.x = moveVector.x * SPEED;
	self.velocity.y = moveVector.y * SPEED;
	
	var mousePos = get_global_mouse_position()
	var mouseVector = mousePos-global_position;
	
	

	if (abs(moveVector.x)+abs(moveVector.y) > 0.5):
		$Sprite.position.y = floor(sin(runTimer*20.0))
		$Sprite.flip_h = moveVector.x < 0
	
	
	if (Input.is_action_just_pressed("fire") and not firing):
		firing = true
		fireCount = 0
	if (firing == true):
		fireCount += delta
		var target = -atan2(mouseVector.x, mouseVector.y);
		var max = PI/2.0
		if (target < max):
			target = -max
		elif(target > max):
			target = max
		$Staff.global_rotation = lerp($Staff.global_rotation, target, delta * 100.0)
		if (fireCount > 0.25):
			firing = false
		$Sprite.flip_h = mouseVector.x < 0
	else:
		$Staff.global_rotation = lerp($Staff.global_rotation, 0.0, delta * 5.0)
	move_and_slide()
	pass
