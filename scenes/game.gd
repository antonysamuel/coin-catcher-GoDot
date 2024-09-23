extends Node2D


const EXPLODE = preload("res://assets/explode.wav")

@export var gem_scene: PackedScene 


var _score:int = 0
var _life:int = 4
@onready var label: Label = $Label
@onready var timer: Timer = $Timer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var heartIcons = $HBoxContainer.get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_gem()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_gem_on_gem_off_screen() -> void:
	print("gem off screen")

func spawn_gem() -> void:
		var new_gem: Gem = gem_scene.instantiate()
		var xpos: float = randf_range(70,get_viewport_rect().size.x - 100)
		new_gem.position = Vector2(xpos, -50)
		new_gem.on_gem_off_screen.connect(update_life)
		add_child(new_gem)

func stop_all()-> void:
	timer.stop()
	for child in get_children():
		child.set_process(false)

func player_dead() -> void:
	audio_stream_player_2d.stop()
	audio_stream_player_2d.stream = EXPLODE
	audio_stream_player_2d.play()

func game_over()-> void:
	print("Game Over")
	player_dead()
	stop_all()

func _on_timer_timeout() -> void:
	spawn_gem()


func _on_paddle_area_entered(area: Area2D) -> void:
	_score += 1
	label.text = "%05d" %_score
	audio_stream_player_2d.position = area.position
	audio_stream_player_2d.play()
	
	#increase complexity:
	timer.wait_time -= _score%5 * 0.1
	area.queue_free()

func update_hearts() ->void:
	for i in range(_life,4):
		#heartIcons[len(heartIcons) - 1 - i].visible = false
		heartIcons[i].visible = false
		

func update_life() -> void:
	if _life > 0:
		_life -= 1
		update_hearts()
	else:
		game_over()
