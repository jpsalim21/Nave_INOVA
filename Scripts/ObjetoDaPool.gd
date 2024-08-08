class_name ObjetoDaPool
extends Node2D

var pool : ObjectPool

func _ready():
	ativar(false, Vector2.ZERO)
	pool = get_parent() as ObjectPool

func ativar(a : bool, pos : Vector2):
	global_position = pos
	visible = a
