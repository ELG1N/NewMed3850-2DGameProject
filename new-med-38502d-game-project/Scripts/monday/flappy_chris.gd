extends CharacterBody2D
const MAX_DOWN = 90
const MAX_UP = -85
const SPEED = 75.0
const JUMP_VELOCITY = -130.0
var is_dead: bool = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += (get_gravity()/1.75) * delta
		velocity.x = SPEED 
		rotation_degrees = clamp(velocity.y * 0.175, MAX_UP, MAX_DOWN)
		if is_dead == false:
			if Input.is_action_just_pressed("Jump"):
				velocity.y = JUMP_VELOCITY
				%AnimatedSprite2D.play("Fly")
	move_and_slide()

	
func Die():
	is_dead = true
	self.velocity.x = 0
	%AnimatedSprite2D.play("die")
	%AnimatedSprite2D.stop()
	await get_tree().create_timer(4.5).timeout
	get_tree().reload_current_scene()


func _on_kill_body_entered(body: Node2D) -> void:
	Die()
