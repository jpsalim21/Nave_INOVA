extends Node

@onready var timer : Timer = $Timer
@onready var enemy_pool = $"../EnemyPool"

@export var tempoMin : float
@export var tempoMax : float

func _ready():
	timer.timeout.connect(spawnEnemy)
	timer.start(randf_range(tempoMin, tempoMax))

func spawnEnemy():
	var posX = randi_range(-130, 130)
	enemy_pool.instanciar(Vector2(posX, -92))
	timer.start(randf_range(tempoMin, tempoMax))
