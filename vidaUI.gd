extends HBoxContainer

var coracoes : Array[Control] = []


func _ready() -> void:
	var filhos = get_children()
	for obj in filhos:
		coracoes.append(obj as Control)
	
	GameController.mudouVida.connect(atualizaUI)


func atualizaUI(valor : int):
	for i in coracoes.size():
		if i < valor:
			coracoes[i].self_modulate = Color.WHITE
		else:
			coracoes[i].self_modulate = Color.BLACK
