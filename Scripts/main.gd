extends Node

@export var mob_scene: PackedScene
@export var coin_scene: PackedScene
var score

func game_over():
	$CoinTimer.stop()
	$Music.stop()
	$GameOverSound.play()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()

func new_game():
	$CoinTimer.start()
	$Music.play()
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("C'EST PARTI !")

func _on_start_timer_timeout():
	$ScoreTimer.start()
	$MobTimer.start()

func _on_score_timer_timeout():
	score += 1
	increase_score_hud()

func increase_score_hud():
	$HUD.update_score(score)

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf() #Prend un point aléatoire sur le path
	
	var direction = mob_spawn_location.rotation + PI / 2; #Renvoi la direction du joueur a l'inverse de la direction dans laquelle les murs sont
	
	mob.position = mob_spawn_location.position
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)

func _on_coin_timer_timeout():
	spawn_coin()

func spawn_coin():
	var newcoin = coin_scene.instantiate()
	
	var xpos_ = randf_range(20 ,460)
	var ypos_ = randf_range(20, 700)
	var spawn_position = Vector2(xpos_, ypos_)
	
	newcoin.position = Vector2(xpos_, ypos_)
	
	var coinsparent = get_node("CoinsParent")
	
	if coinsparent != null:
		coinsparent.add_child(newcoin)
	else:
		print("Error: coinsparent node not found")

func set_score(new_score):
	score = new_score
	$HUD.update_score(score)
