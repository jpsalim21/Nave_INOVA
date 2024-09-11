extends Label

func _ready() -> void:
	GameController.mudouPontuacao.connect(atualizarPontuacao)

func atualizarPontuacao(valor):
	text = str(valor)
