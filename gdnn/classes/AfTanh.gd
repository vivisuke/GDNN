class_name AfTanh
extends Layer


func _init(nOutput):
	super(LT_TANH, nOutput)
func forward(inputs):
	for o in range(m_nOutputs):
		m_outputs[o] = tanh(inputs[o])
func backward(grad):
	for o in range(m_nOutputs):
		m_grad[o] = 1.0 - m_outputs[o] * m_outputs[o]
func _ready():
	pass # Replace with function body.
func _process(delta):
	pass
