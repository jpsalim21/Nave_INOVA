extends Node

var pontuacao : int = 0
signal mudouPontuacao(novoValor : int)

var vida : int = 3
signal mudouVida(novoValor : int)

func aumentarPontuacao(valor : int):
	pontuacao += valor
	mudouPontuacao.emit(pontuacao)

func restartGame():
	pontuacao = 0
	vida = 3
	get_tree().call_deferred("reload_current_scene")

func tomouDano():
	vida -= 1
	mudouVida.emit(vida)
	if vida <= 0:
		restartGame()
