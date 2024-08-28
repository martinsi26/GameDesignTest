extends Node2D

var dialogue = preload("res://Dialogue.tscn")
var speed = 500
var screen_size = Vector2.ZERO
var collected = false
var found_key = false

signal enter_room1
signal enter_room2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

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
		
	if found_key == true && Input.is_action_pressed("Pick_Up"):
		pick_up()
		
	if direction.length() > 1:
		direction = direction.normalized()
	
	position += direction * speed * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
		
func pick_up():
	collected = true
	get_parent().get_node("Room1/Key").visible = false
	get_parent().get_node("Room1/Key").set_collision_layer(0)
	get_parent().get_node("Room1/Key").set_collision_mask(0)
	
func show_key():
	var d
	if found_key == false:
		get_parent().get_node("Room1/Key").visible = true
		d = dialogue.instantiate()
		add_child(d)
		found_key = true
	
func _on_area_2d_body_entered(body):
	if body.name == "Key":
		show_key()
	elif body.name == "Path1":
		emit_signal("enter_room2")
		#get_tree().change_scene_to_file("res://Room2.tscn")
	elif body.name == "Path1Back":
		emit_signal("enter_room1")
