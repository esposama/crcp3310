# CRCP 3310 Project 3: This is a simple database-backed song application. 

require "sqlite3"

DB_FILE_NAME = "songs.sqlite3.db"
SQL_SELECT_GENRE_NAME = "SELECT name FROM genres WHERE id = 1" 
SQL_SELECT_SONGS = "SELECT name, genre_id, album_id FROM     "
SQL_SELECT_ALBUM_ROW = "SELECT name, artist_id FROM album   "
SQL_SELECT_ARTISTS_NAME = "SELECT name FROM artists WHERE    "
SQL_SELECT_GENRES = "SELECT * FROM genres"
SQL_SELECT_ALBUM = "SELECT * FROM albums"
db = SQLite3::Database.new(DB_FILE_NAME)


def initialize_startscreen 
	puts "Welcome to the music database!"
	puts "1. Display all song information."
	puts "2. Add a new genre."
	puts "3. Add a new album."
	puts "4. Add a new artist."
	puts "5. Add a new song."
	puts "Enter a choice: "
end 
def add_new_song
	puts "Songs in the database: "
	@db.execute(SQL_SELECT_SONG) do |row| 
		puts row[1]
	end 
	puts "New song name: "
	user_song = gets 
	user_song.chomp 
	id = @db.execute("SELECT Count(*) FROM songs") [0][0] 
	id += 1 
	@db.execute("INSERT INTO songs VALUES ('#{id}', '#{user_song}")
end 

def add_new_genre 
	puts "Genres in the database: "
	@db.execute(SQL_SELECT_GENRE) do |row| 
		puts row[1]
	end 
	puts "New genre name: "
	user_genre = gets 
	user_genre.chomp 
	id = @db.execute("SELECT Count(*) FROM genres") [0][0] 
	id += 1 
	@db.execute("INSERT INTO genres VALUES ('#{id}', '#{user_genre}")
end 

def add_new_album 
	puts "Albums in the database: "
	@db.execute(SQL_SELECT_ALBUM) do |row| 
		puts row[1]
	end 
	puts "New album name: "
	user_album = gets 
	user_album.chomp 
	id = @db.execute()
db.execute(SQL_SELECT_GENRES) do |row| 
	p row 
end 

db.close 
