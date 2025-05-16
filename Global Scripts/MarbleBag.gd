extends Node

###########################################################################################################################################
# README: 
# An interface for managing random outcomes, designed to minimize repeated results in succession.
# 
###########################################################################################################################################
class_name MarbleBag

var full_bag: Array
var _current_bag: Array

func _init(_contents: Array):
	full_bag = _contents

func Reset():
	_current_bag.clear()
	for item in full_bag:
		_current_bag.insert(randi_range(0, _current_bag.size()), item)

func Next():
	if _current_bag.is_empty():
		Reset()
	var result = _current_bag.get(0)
	_current_bag.remove_at(0)
	return result