extends CharacterBody2D

var speed = 800

var myCenter = Vector2(0,0)
var myRadius = 345
var myColor = _generate_random_rgb_color()
var acceleration = 0
var collisionCount = 0

@onready var hit: AudioStreamPlayer = $hit
@onready var label: Label = $Label


func _ready():
	velocity = Vector2(-200, -200).normalized() * speed
	_draw()

func _draw():
	draw_circle(myCenter,myRadius,myColor)

func _physics_process(delta):
	var collision = move_and_collide(velocity * (delta + acceleration))
	if collision:
		hit.play()
		velocity = velocity.bounce(collision.get_normal())
		myColor = _generate_random_rgb_color()
		queue_redraw()
		collisionCount = collisionCount + 1
		$Label.text = str(acceleration)

		if collisionCount >= 10:
			acceleration = acceleration + 0.0030
			collisionCount = 0
		if acceleration > 0.1:
			acceleration = 0
			

func _generate_random_rgb_color() -> Color:
	return Color(
		randf(),
		randf(),
		randf()
)
