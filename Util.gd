extends Node
class_name Util

static func find_game_parent(node: Node) -> Game:
	var parent := node.get_parent()
	if parent == null:
		return null
	if parent is Game:
		return parent
	return find_game_parent(parent)

static func color_to_vec3(c: Color) -> Vector3:
	return Vector3(c.r, c.g, c.b)
