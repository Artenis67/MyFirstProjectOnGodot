extends Area2D

@export var main_scene: PackedScene
var coin_value = 1

func _on_body_entered(body):
	increase_score(coin_value)

func increase_score(score_):
	main_scene.score += score_
