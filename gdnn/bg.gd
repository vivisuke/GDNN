extends ColorRect

const NODE_R = 25
const NODE_X0 = 50
const NODE_Y0 = 50
const NODE_DX = 150
const NODE_DY = 75

var net

func draw_node(px, py, col):
	draw_circle(Vector2(px, py), NODE_R, col)
	draw_circle(Vector2(px, py), NODE_R, Color.BLACK, false, 0.75, true)

func _draw():
	print("net.m_nInputs = ", net.m_nInputs)
	var px = NODE_X0
	var py = NODE_Y0
	for l in range(net.m_layers.size()):
		var layer = net.m_layers[l]
		if layer.m_type == Layer.LT_AFFINE:
			var nInputs = net.m_nInputs if l == 0 else layer.m_nInputs
			var sx = px;
			px += NODE_DX
			var sy = NODE_Y0
			py = NODE_Y0
			for d in range(layer.m_nOutputs):
				py += NODE_DY
				draw_line(Vector2(sx, sy), Vector2(px, py), Color.BLACK, 0.5, true)
			for s in range(nInputs):
				py = NODE_Y0
				sy += NODE_DY
				for d in range(layer.m_nOutputs):
					py += NODE_DY
					draw_line(Vector2(sx, sy), Vector2(px, py), Color.BLACK, 0.5, true)
	px = NODE_X0
	py = NODE_Y0
	for y in range(net.m_nInputs):
		py += NODE_DY
		draw_node(px, py, Color.WHITE)
	for l in range(net.m_layers.size()):
		var layer = net.m_layers[l]
		if layer.m_type == Layer.LT_AFFINE:
			px += NODE_DX
			py = NODE_Y0
			if layer.m_type == Layer.LT_AFFINE:
				draw_node(px-NODE_DX, py, Color.GRAY)
			for y in range(layer.m_nOutputs):
				py += NODE_DY
				draw_node(px, py, Color.WHITE)
	pass
func _ready():
	pass # Replace with function body.
func _process(delta):
	pass
