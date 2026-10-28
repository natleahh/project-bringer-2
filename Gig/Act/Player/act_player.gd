class_name ActPlayer extends Node

signal tock

@export var state: ActState
@export var play_display: Texture2D:
	get: return null if node == null else node.data.texture


var node: ActNode
var connector: ActConnector
var next: ActConnector

var timer: Timer = Timer.new()
@export var wait_time: float:
	set(s): timer.wait_time = s
	get: return timer.wait_time
@export var progress: float:
	get: return timer.time_left / timer.wait_time

func _ready() -> void:
	add_child(timer)
	timer.timeout.connect(tick)
	timer.one_shot = true
	timer.autostart = false

func play(_node: ActNode) -> void:
	node = _node
	timer.start()

func tick() -> void:
	next = get_next()
	if not timer.is_stopped() or next == null:
		return
	connector = next.partner
	play(connector.bit)
	tock.emit()
 
func get_next() -> ActConnector:
	if not node:
		return 
	var options = node.active_connectors.filter(func (c): return c != connector)
	return options[0] if options.size() == 1 else null
