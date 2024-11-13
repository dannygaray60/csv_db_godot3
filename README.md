# CSV as Database file in Godot Engine 3.x
The `csvdb_loader.gd` file allows you to load CSV format files and use those data in Dictionary form. This way you can work comfortably changing values using Excel or Libreoffice calc.

## How to use
Download the `csvdb_loader.gd` file and add it to any part of your project. Then make it inside the Autoload so you can use it in any part of the code. This way automatically the script will look for csv files and load all values in dictionary form. But first change the parameters at the beginning of the script:

### Defining variables
-- First define the path where the csv files will be saved with the variable `dbs_path`.  
-- Define in the variable `delimiter` which character will be used to separate the values, by default is the comma, it is recommended not to change it if you will edit the files with excel or libreoffice.  
-- Also specify the extension of the files in the `file_ext` variable, you can use `.csv` but that would make godot import those files as translation files. I recommend using another extension, like `.csvdb` or `.txt` It doesn't matter the extension, but the file content must be with values separated by a delimiter, like a comma.

### Method
`get_db(db_name:String) -> Dictionary`
Gets the CSV values you specify via the filename (omitting the extension) and will store it in a Dictionary.

### Example of use
##### Assuming you have a database (weapons.csvdb) like this:
![](https://raw.githubusercontent.com/dannygaray60/csv_db_godot3/refs/heads/main/example.png)

##### Then you can load the data in this way:

    var weapons : Dictionary = Csvdb_loader.get_db("weapons")

    ## get all weapons
    for weapon_key in weapons:
	    print(weapons[weapon_key])

     ## or using a key get the weapon data:
     print(weapons["whip"]["power"])

---
## Script by: dannygaray60
### License: MIT
