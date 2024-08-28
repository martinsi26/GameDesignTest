extends CharacterBody2D

var dialogue = preload("res://Dialogue.tscn")
var speed = 500
var collected = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("Move_Up"):
		direction.y -= 1
	if Input.is_action_pressed("Move_Down"):
		direction.y += 1
	if Input.is_action_pressed("Move_Left"):
		direction.x -= 1
	if Input.is_action_pressed("Move_Right"):
		direction.x += 1
		
	if direction.length() > 1:
		direction = direction.normalized()
	
	#self.position += direction * speed * delta
	var collision_info = move_and_collide(direction * speed * delta)
		
func pick_up():
	collected = true
	$"../Key".visible = false
	$"../Key".set_collision_layer(0)
	$"../Key".set_collision_mask(0)
	
func show_key():
	$"../Key".visible = true
	var d = dialogue.instantiate()
	add_child(d)
	#if Input.is_action_pressed("Pick_Up"):
	pick_up()
	
func _on_area_2d_body_entered(body):
	if body.name == "Key":
		show_key()
	elif body.name == "Path1":
		get_tree().change_scene_to_file("res://Room2.tscn")
	elif body.name == "Path1Back":
		get_tree().change_scene_to_file("res://Room1Back.tscn")
