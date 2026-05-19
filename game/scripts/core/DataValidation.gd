extends RefCounted
class_name DataValidation

static func has_required_fields(record: Dictionary, required_fields: Array, source_name: String) -> bool:
	var valid: bool = true
	var record_id: String = "unknown"

	if record.has("id"):
		record_id = str(record["id"])

	for raw_field: Variant in required_fields:
		var field_name: String = str(raw_field)
		if not record.has(field_name):
			push_error("%s record '%s' missing required field: %s" % [source_name, record_id, field_name])
			valid = false

	return valid
