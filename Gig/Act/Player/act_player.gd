class_name ActPlayer extends Node

signal no_next_option(connectors: Array[ActConnector])

var state: ActState

var connector: ActConnector
var blocked_links: ActConnector = []
@onready var timer: Timer = %Timer
@export var wait_time: float:
	set(s): timer.wait_time = s
	get: return timer.wait_time

func _ready() -> void:
	timer.timeout.connect(tick)
	timer.one_shot = true

func play_from_bit(_bit: ActNode) -> void:
	var options = (
		_bit.get_bridges()
		.filter(func (c: ActConnector): return c.link.active and c != connector)
	)
	if options.size() == 1:
		play_from_connector(options[0])
	else:
		no_next_option.emit(options)

func play_from_connector(_connector: ActConnector) -> void:
	if not _connector.link.active:
		state.toggle_link(_connector.link)
	connector = _connector
	timer.start()


func tick() -> void:
	if not timer.is_stopped():
		return
	timer.start()
	play_from_bit(connector.partner.bit)
