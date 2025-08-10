extends Polygon2D

@export var radius: float = 8
@export var sides: int = 32

func _ready():
	var points = []
	for i in range(sides):
		var angle = (i / float(sides)) * TAU
		points.append(Vector2(cos(angle), sin(angle)) * radius)
	
	polygon = points
