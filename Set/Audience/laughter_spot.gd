class_name LaughterSpot extends Control

var emitting: bool:
	set(b): %GPUParticles2D.emitting = b
	
var color: Color = Color("white"):
	set(b): %GPUParticles2D.modulate = b
