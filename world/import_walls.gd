@tool
extends EditorScenePostImport


func _post_import(scene: Node) -> Object:
	for child in scene.get_children():
		if child.name.begins_with("Tap"):
			scene.remove_child(child)
			child.queue_free()
			var tap := preload("res://world/tap.tscn").instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
			scene.add_child(tap)
			tap.owner = scene
			tap.name = child.name
			tap.transform = child.transform
	return scene
