extends CharacterBody2D

var speed = 800

var acceleration = 0
var collisionCount = 0

@onready var hit: AudioStreamPlayer = $hit



func _ready():
	velocity = Vector2(-200, -200).normalized() * speed
	

func _physics_process(delta):
	var collision = move_and_collide(velocity * (delta + acceleration))
	if collision:
		hit.play()
		velocity = velocity.bounce(collision.get_normal())
		collisionCount = collisionCount + 1

		if collisionCount >= 10:
			acceleration = acceleration + 0.0030
			collisionCount = 0
		if acceleration > 0.1:
			acceleration = 0
			
