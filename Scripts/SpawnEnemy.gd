extends Node

@onready var timer : Timer = $Timer
var enemy : PackedScene = preload("res://PackedScenes/inimigo_2.tscn")
var inimigos : Array[PackedScene] = [
	preload("res://PackedScenes/inimigo_1.tscn"),
	preload("res://PackedScenes/inimigo_2.tscn")
]

@export var tempoMin : float
@export var tempoMax : float

func _ready():
	timer.timeout.connect(spawnEnemy)
	timer.start(randf_range(tempoMin, tempoMax))

func spawnEnemy():
	var posX = randi_range(-130, 130)
	var obj : Node2D = inimigos.pick_random().instantiate()
	obj.global_position = Vector2(posX, -92)
	add_child(obj)
	timer.start(randf_range(tempoMin, tempoMax))
