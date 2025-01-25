extends Node
class_name Util

static func find_game_parent(node: Node) -> Game:
	var parent := node.get_parent()
	if parent == null:
		return null
	if parent is Game:
		return parent
	return find_game_parent(parent)
