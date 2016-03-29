# CRCP 3310 Project 3: This is a simple database-backed song application. 

require "sqlite3"

DB_FILE_NAME = "songs.sqlite3.db"
SQL_SCHEMA = "SELECT songs.name, genres.name, artists.name, albums.name FROM songs, genres, artists, albums WHERE artists.id = albums.artist_id AND genres.id = songs.genre_id AND albums.id = songs.album_id"
SQL_SELECT_ALBUMS = "SELECT name FROM albums"
SQL_SELECT_GENRE_NAME = "SELECT name FROM genres" 
SQL_SELECT_ARTISTS = "SELECT name FROM artists"
SQL_SELECT_ALBUM = "SELECT * FROM albums"
SQL_SELECT_GENRES = "SELECT * FROM genres"
SQL_SELECT_ARTISTS = "SELECT * FROM artists"
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
	puts "New song name: "
	user_song = gets 
	user_song.chomp 
	puts "Genres: "
	@db.execute(SQL_SELECT_GENRES) do |row| 
		puts "#{row[0]}. #{row[1]}}"
	end 
	puts "Select a genre's id: "
	song_genre_id = gets 
	song_genre_id.chomp 
	puts "Albums: "
	db.execute(SQL_SELECT_ALBUMS) do |row| 
		puts "#{row[0]}. #{row[1]}}"
	end 
	puts "Select an album's id: "
	song_album_id = gets 
	song_album_id.chomp 
	song_name = "INSERT INTO songs(name, genre_id, album_id) VALUES (('#{user_song}, '#{song_genre_id}', '#{song_album_id}')" 
	db.execute(song_name)
end 

def add_new_genre 
	puts "Genres in the database: "
	@db.execute(SQL_SELECT_GENRE) do |row| 
		puts row[1]
	end 
	puts "New genre name: "
	user_genre = gets 
	user_genre.chomp 
	genres_table = "INSERT INTO genres (name) VALUES ('#{user_genre}')"
	db.execute(genres_table)
	db.execute(SQL_SELECT_GENRES) do |row| 
		puts row[1]
	end 
end 

def add_new_album 
	puts "Albums in the database: "
	@db.execute(SQL_SELECT_ALBUM) do |row| 
		puts row[1]
	end 
	puts "New album name: "
	user_album = gets 
	user_album.chomp 
	db.execute(SQL_SELECT_ARTISTS) do |row| 
		puts "{row[0]}. #{row[1]}" 
	end
	puts "Select an artist's id: " 
	artist_id = gets 
	artist_id.chomp 
	artist_id_column = "INSERT INTO albums (name, artist_id) VALUES ('#{user_album}, '#{artist_id}')"
	db.execute(artist_id_column)
end 
def add_new_artist
	puts "Artists in the database: "
	@db.execute(SQL_SELECT_ARTISTS) do |row| 
		puts row[1]
	end 
	puts "New artist name: "
	user_artist = gets 
	user_artist.chomp 
	artist_table = "INSERT INTO artist (name) VALUES ('#{user_artist}')"
	db.execute(artists_table)
	db.execute(SQL_SELECT_ARTISTS) do |row| 
		puts row[1]
	end 
end 

def add_new_schema 
	puts "[song name] | [genre] | [artist] | [album]"
	db.execute(SQL_SCHEMA) do |row| 
		puts row.join " | "
	end 
end 


db.close 
