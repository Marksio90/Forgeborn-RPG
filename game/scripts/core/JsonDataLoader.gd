extends RefCounted
class_name JsonDataLoader

static func load_json_file(path: String) -> Variant:
	if not FileAccess.file_exists(path):
		push_error("JSON file not found: %s" % path)
		return null

	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("Could not open JSON file: %s" % path)
		return null

	var text := file.get_as_text()
	file.close()

	var json := JSON.new()
	var parse_error := json.parse(text)
	if parse_error != OK:
		push_error(
			"Failed to parse JSON file: %s (line %d) error: %s"
			% [path, json.get_error_line(), json.get_error_message()]
		)
		return null

	return json.data
