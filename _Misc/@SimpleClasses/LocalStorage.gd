extends Reference

class_name LocalStorage

### FUNCTIONS ###
# --- Publics ---
# Write internal dictionary to encrypted file in json format
static func write_json(path:String, data: Dictionary, passwd := "0092140662") -> bool:
	var file = File.new()
	if file.open_encrypted_with_pass(path, File.WRITE, passwd):
		return false
	file.store_string(to_json(data))
	file.close()
	return true

# Read from encrypted file and load as json.
static func read_json(path: String, passwd := "0092140662") -> Dictionary:
	var file = File.new()
	
	# if file not found, return
	if file.open_encrypted_with_pass(path, File.READ, passwd):
		return {}
	
	var parse_result := JSON.parse(file.get_as_text())
	file.close()
	
	return {} if parse_result.error else parse_result.result
