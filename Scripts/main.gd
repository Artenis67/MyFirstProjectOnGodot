extends Node

@export var mob_scene: PackedScene
@export var coin_scene: PackedScene
var score

func game_over():
	$Music.stop()
	$GameOverSound.play()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()

func new_game():
	$Music.play()
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("C'EST PARTI !")

func _on_start_timer_timeout():
	$ScoreTimer.start()
	$MobTimer.start()
	$CoinsTimer.start()

func _on_score_timer_timeout():
	score += 1
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

func _on_coins_timer_timeout():
	var new_coin_position_x = randf_range(80, 400)
	var new_coin_position_y = randf_range(80, 680)
	
	var new_coin = coin_scene.instantiate()
	
	new_coin.position = Vector2(new_coin_position_x, new_coin_position_y)
	
	add_child(new_coin)
	
	print("Coin timer timeout")

