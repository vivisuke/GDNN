class_name AffineMap
extends Layer

var rng = 0
var m_last_inputs = []
var m_bias = []
var m_weights = [[]]		# [out][in]
var m_dbias = []			# ∂L/∂b
var m_dweights = [[]]		# ∂L/∂W [out][in]

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
	m_grad.resize(nInput)
	var std = 1.0/sqrt(nInput)
	m_bias.resize(m_nOutput)
	m_weights.resize(m_nOutput)
	m_dbias.resize(m_nOutput)
	m_dweights.resize(m_nOutput)
	for o in range(m_nOutput):
		m_bias[o] = rng.randfn(0.0, std)
		m_weights[o] = []
		m_weights[o].resize(m_nInput)
		for i in range(m_nInput):
			m_weights[o][i] = rng.randfn(0.0, std)
		m_dweights[o] = []
		m_dweights[o].resize(m_nInput)
	pass
func set_weights(vv):
	for o in range(m_nOutput):
		var v = vv[o]
		m_bias[o] = v[0]
		for i in range(m_nInput):
			m_weights[o][i] = v[i+1]
func init_dweights():
	for o in range(m_nOutput):
		m_dbias[o] = 0.0
		for i in range(m_nInput):
			m_dweights[o][i] = 0.0
func forward(inputs):
	m_last_inputs = inputs
	for o in range(m_nOutput):
		var sum = m_bias[o]
		for i in range(m_nInput):
			sum += m_weights[o][i] * inputs[i]
		m_outputs[o] = sum
# 誤差逆伝播
#		下流 grad から誤差を計算し m_grad に格納
#		∂L/∂W を計算 → m_dbias, m_dweights に格納
func backward(grad):
	for i in range(m_nInput):
		var sum = 0.0
		for o in range(m_nOutput):
			sum += m_weights[o][i] * grad[o]
		m_grad[i] = sum
	for o in range(m_nOutput):
		m_dbias[o] = grad[o]
		m_dweights[o].fill(0.0)
		for i in range(m_nInput):
			m_dweights[o][i] += m_last_inputs[i] * grad[o]

func _ready():
	pass # Replace with function body.
func _process(delta):
	pass
