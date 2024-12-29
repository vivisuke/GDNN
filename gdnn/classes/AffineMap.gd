class_name AffineMap
extends Layer

var rng = 0
var m_bias = []
var m_weights = [[]]		# [out][in]

func _init(nOutput):
	super(1, nOutput)
	rng = RandomNumberGenerator.new()
func print():
	print("AffineMap:")
	print(" nInput = ", m_nInput)
	print(" nOutput = ", m_nOutput)
	print(" bias = ", m_bias)
	print(" weights[o][i] = ")
	for o in range(m_nOutput):
		print("   ", m_weights[o])
	print(" outputs = ", m_outputs)
func set_nInput(nInput):
	m_nInput = nInput
	var std = 1.0/sqrt(nInput)
	m_bias.resize(m_nOutput)
	m_weights.resize(m_nOutput)
	for o in range(m_nOutput):
		m_bias[o] = rng.randfn(0.0, std)
		m_weights[o] = []
		m_weights[o].resize(m_nInput)
		for i in range(m_nInput):
			m_weights[o][i] = rng.randfn(0.0, std)
	pass
func forward(inputs):
	for o in range(m_nOutput):
		var sum = m_bias[o]
		for i in range(m_nInput):
			sum += m_weights[o][i] * inputs[i]
		m_outputs[o] = sum

func _ready():
	pass # Replace with function body.
func _process(delta):
	pass
