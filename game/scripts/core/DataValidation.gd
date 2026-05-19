extends RefCounted
class_name DataValidation

static func has_required_fields(record: Dictionary, required_fields: Array[String], source_name: String) -> bool:
	var valid: bool = true
	for field: String in required_fields:
		if not record.has(field):
			push_error("%s missing required field: %s" % [source_name, field])
			valid = false
	return valid
