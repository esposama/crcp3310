require 'sqlite3'

DB_FILE_NAME = "songs.sqlite3.db"
SQL_SELECT_GENRES = "SELECT name from genres;"

db = SQlite3::Database.new(DB_FILE_NAME)

db.execute(SQL_SELECT_GENRES) do |row| 
	p row 
end 

db.close 








//puts "Add an album..."
//puts "Enter the album name: "
//db.execute("SELECT * FROM artists;") do |row| 
//	puts "#{row[0]. #{row[1]}"
//end 

//puts "Select an artist: "
//artist_id = gets.chomp 

//db.execute("INSERT INTO albums(name, artist_id) VALUES(...)") 