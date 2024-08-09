class_name ObjectPool
extends Node

@export var objeto : PackedScene
@export var tamanhoInicial : int

var emUso : Array[ObjetoDaPool] = []
var disponiveis : Array[ObjetoDaPool] = []

func _ready():
	if not objeto:
		printerr("Objeto não foi escolhido. Deletando object pool", self)
		queue_free()
	else:
		for i in tamanhoInicial:
			criarObj()

func criarObj():
	var objetoAdicionar = objeto.instantiate() as ObjetoDaPool
	add_child(objetoAdicionar)
	objetoAdicionar.global_position = Vector2(200,200)
	disponiveis.append(objetoAdicionar)

func instanciar(pos : Vector2):
	if disponiveis.is_empty():
		criarObj()
		return
	var objetoInstanciar : ObjetoDaPool = disponiveis.pop_front()
	emUso.append(objetoInstanciar)
	objetoInstanciar.ativar(true, pos)

func voltarAosDisponiveis(obj : ObjetoDaPool):
	disponiveis.append(obj)
	emUso.erase(obj)
