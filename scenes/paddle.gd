extends Area2D



@export var speed: float = 250



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x +=  Input.get_axis("move_left","move_right") * speed * delta
