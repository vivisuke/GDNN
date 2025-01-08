class_name AffineMap
extends Layer

var rng = 0
var m_last_inputs = []
var m_bias = []
var m_weights = [[]]		# [out][in]
var m_dbias = []			# ∂L/∂b
var m_dweights = [[]]		# ∂L/∂W [out][in]

func _init(nOutput):
	super(LT_AFFINE, nOutput)
	rng = RandomNumberGenerator.new()
func print():
	print("AffineMap:")
	print(" nInputs = ", m_nInputs)
	print(" nOutput = ", m_nOutputs)
	#print(" bias = ", m_bias)
	print(" weights[o][i] = ")
	for o in range(m_nOutputs):
		print("   ", m_bias[o], ", ", m_weights[o])
	print(" dweights[o][i] = ")
	for o in range(m_nOutputs):
		print("   ", m_dbias[o], ", ", m_dweights[o])
	print(" outputs = ", m_outputs)
func weights_text():
	var txt = "["
	for o in range(m_nOutputs):
		txt += "[%.2f, "%m_bias[o]
		for i in range(m_nInputs):
			txt += "%.2f, "%m_weights[o][i]
		txt += "] ,"
	txt += "]"
	return txt
func dweights_text():
	var txt = "[%.2f, "%m_dbias[0]
	for i in range(m_nInputs):
		txt += "%.2f, "%m_dweights[0][i]
	txt += "]"
	return txt
func get_weights():
	var w = []
	w.resize(m_nOutputs)
	for o in range(m_nOutputs):
		w[o] = [m_bias[o]]
		for i in range(m_nInputs):
			w[o].push_back(m_weights[o][i])
	return w
func set_nInputs(nInputs):
	m_nInputs = nInputs
	m_grad.resize(nInputs)
	var std = 1.0/sqrt(nInputs)
	m_bias.resize(m_nOutputs)
	m_weights.resize(m_nOutputs)
	m_dbias.resize(m_nOutputs)
	m_dweights.resize(m_nOutputs)
	for o in range(m_nOutputs):
		m_bias[o] = rng.randfn(0.0, std)
		m_weights[o] = []
		m_weights[o].resize(m_nInputs)
		for i in range(m_nInputs):
			m_weights[o][i] = rng.randfn(0.0, std)
		m_dweights[o] = []
		m_dweights[o].resize(m_nInputs)
	pass
func set_weights(vv):
	for o in range(m_nOutputs):
		var v = vv[o]
		m_bias[o] = v[0]
		for i in range(m_nInputs):
			m_weights[o][i] = v[i+1]
func init_dweights():
	for o in range(m_nOutputs):
		m_dbias[o] = 0.0
		for i in range(m_nInputs):
			m_dweights[o][i] = 0.0
func forward(inputs):
	m_last_inputs = inputs
	for o in range(m_nOutputs):
		var sum = m_bias[o]
		for i in range(m_nInputs):
			sum += m_weights[o][i] * inputs[i]
		m_outputs[o] = sum
# 誤差逆伝播
#		下流 grad から誤差を計算し m_grad に格納
#		∂L/∂W を計算 → m_dbias, m_dweights に格納
func backward(grad):
	for i in range(m_nInputs):
		var sum = 0.0
		for o in range(m_nOutputs):
			sum += m_weights[o][i] * grad[o]
		m_grad[i] = sum
	for o in range(m_nOutputs):
		m_dbias[o] += grad[o]
		for i in range(m_nInputs):
			print("m_last_inputs[%] * grad[%] = %f"%[i, o, m_last_inputs[i] * grad[o]])
			m_dweights[o][i] += m_last_inputs[i] * grad[o]
			print("m_dweights[%d][%d] = %f"%[o, i, m_dweights[o][i]])
func update_weights(alpha):
	for o in range(m_nOutputs):
		m_bias[o] -= m_dbias[o] * alpha
		for i in range(m_nInputs):
			m_weights[o][i] -= m_dweights[o][i] * alpha

func _ready():
	pass # Replace with function body.
func _process(delta):
	pass
