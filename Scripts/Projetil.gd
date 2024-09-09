class_name Projetil
extends Node2D

@onready var colisao = $CollisionShape2D
@onready var timer : Timer = $Timer

var speed = 300

func _ready() -> void:
	timer.timeout.connect(queue_free)

func _process(delta):
	global_position.y -= speed * delta
