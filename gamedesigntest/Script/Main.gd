extends Node2D

var room1 = preload("res://Scene/Room1.tscn")
var room2 = preload("res://Scene/Room2.tscn")

var instance1 = room1.instantiate()
var instance2 = room2.instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(instance1)
	$Cat.position = instance1.get_node("Spawn").position

func _on_cat_enter_room_1() -> void:
	instance2.queue_free()
	instance2 = room2.instantiate()
	add_child(instance1)
	$Cat.position = instance1.get_node("Back").position

func _on_cat_enter_room_2() -> void:
	instance1.queue_free()
	instance1 = room1.instantiate()
	add_child(instance2)
	$Cat.position = instance2.get_node("Spawn2").position
