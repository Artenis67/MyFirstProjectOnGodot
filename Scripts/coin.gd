extends Area2D

@export var main_scene: PackedScene
var coin_value = 1

func _on_area_entered(area):
	# Vérifiez si l'objet qui entre en collision a un nom "Player"
	if area.name == "Player":
		# Obtenez le noeud principal en instanciant la scène principale
		var main_node = main_scene.instance()
		# Vérifiez si le noeud principal existe
		if main_node != null:
			# Obtenez le script principal à partir du noeud principal
			var main_script = main_node.get_script()
			# Augmenter le score dans le script principal
			main_script.score += coin_value
			# Mettre à jour le HUD dans le script principal
			main_script.increase_score_hud()
		else:
			print("Error: Main script node not found")
