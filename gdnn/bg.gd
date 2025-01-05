extends ColorRect

const NODE_R = 25
const NODE_X0 = 50
const NODE_Y0 = 50
const NODE_DX = 150
const NODE_DY = 75

var net

func _draw():
	print("net.m_nInputs = ", net.m_nInputs)
	var px = NODE_X0
	var py = NODE_Y0
	for y in range(net.m_nInputs):
		py += NODE_DY
		draw_circle(Vector2(px, py), NODE_R, Color.WHITE)
		draw_circle(Vector2(px, py), NODE_R, Color.BLACK, false)
	for l in range(net.m_layers.size()):
		var layer = net.m_layers[l]
		px += NODE_DX
		py = NODE_Y0
		for y in range(layer.m_nOutputs):
			py += NODE_DY
			draw_circle(Vector2(px, py), NODE_R, Color.WHITE)
			draw_circle(Vector2(px, py), NODE_R, Color.BLACK, false)
	pass
func _ready():
	pass # Replace with function body.
func _process(delta):
	pass
