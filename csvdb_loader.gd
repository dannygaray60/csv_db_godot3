extends Node

var dbs_path : String = "res://databases"
var delimiter : String = ","
var file_ext : String = ".csvdb"

var _databases : Dictionary

func _ready() -> void:
	load_databases()

func load_databases() -> void:
	for f in FuncsFiles.get_files(dbs_path):
		if f.ends_with(file_ext) == true:
			_load_file(dbs_path+"/"+f)

func get_db(db_name:String) -> Dictionary:
	if _databases.keys().has(db_name) == true:
		return _databases[db_name]
	else:
		return {}

func _load_file(f_path:String) -> void:
	var err : int
	var F := File.new()
	
	err = F.open(f_path,File.READ)
	
	if err == OK and f_path.ends_with(file_ext) == true:
		
		var db_csv : Dictionary = {}
		var headers : PoolStringArray
		var i : int = 0
		
		while not F.eof_reached():

			if i == 0:
				headers = F.get_csv_line(delimiter)
			else:
				var j : int = 0
				var row : PoolStringArray = F.get_csv_line(delimiter)

				## recorrer cada columna en el row
				for col in row:
					## dentro del dict crear otro diccionario
					if j == 0:
						## ignorar si esta vacio
						if col.empty() == true:
							break
						else:
							db_csv[row[j]] = {}
					## y a ese dict añadir keys de la columna y el valor
					else:
						if col.is_valid_integer() == true:
							db_csv[row[0]][headers[j]] = int(col)
						elif col.is_valid_float() == true:
							db_csv[row[0]][headers[j]] = float(col)
						else:
							db_csv[row[0]][headers[j]] = col
					## fin del recorrido de columnas
					j += 1
			## fin de recorrido de filas
			i += 1
		
		## crear entrada de diccionario con el nombre de archivo como key
		_databases[
			f_path.get_file().replace(file_ext,"")
		] = db_csv
	
	else:
		print_debug("Error loading file: "+f_path+" err:"+str(err))
