class_name ActPlayer extends Node

@export var state: ActState
@export var play_display: Texture2D:
	get: return null if connector == null else connector.bit.data.texture

var connector: ActConnector

var timer: Timer = Timer.new()
@export var wait_time: float:
	set(s): timer.wait_time = s
	get: return timer.wait_time

func _ready() -> void:
	add_child(timer)
	timer.timeout.connect(tick)
	timer.one_shot = true
	timer.autostart = false

func play_from_bit(_bit: ActNode) -> void:
	var options = (
		_bit.get_bridges()
		.filter(func (c: ActConnector): return c.link.active and c != connector)
	)
	if options.size() == 1:
		play_from_connector(options[0])

func play_from_connector(_connector: ActConnector) -> void:
	if _connector.link == null:
		return
	if not _connector.link.active:
		state.toggle_link(_connector.link)
	connector = _connector
	timer.start()


func tick() -> void:
	if not timer.is_stopped() or connector == null:
		return
	timer.start()
	play_from_bit(connector.partner.bit)
