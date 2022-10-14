extends Node

signal on_triggered

func trigger():
	emit_signal("on_triggered")
