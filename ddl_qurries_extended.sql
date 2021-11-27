-- Создание таблицы с информацией о исполнителях
create table if not exists artists (
	artist_id serial primary key,
	artist_name varchar(100) unique
);

-- Создание таблицы с информацией об альбомах
create table if not exists albums (
	album_id serial primary key,
	title varchar(100),
	release_year integer
);

-- Создание таблицы с информацией о трэках
create table if not exists tracks (
	track_id serial primary key,
	album_id integer,
	title varchar(100),
	duration integer
);

-- Создание таблицы с информацией о жанрах
create table if not exists genres (
	genre_id serial primary key,
	title varchar(100) unique
);

-- Создание таблицы с информацией о сборниках
create table if not exists mixtapes (
	mixtape_id integer,
	track_id integer,
	album_id integer,
	title varchar(100),
	release_year integer
);

-- Создание дополнительной таблицы с информацией о Артистах и Альбомах
create table if not exists ArtistsAlbums (
	artist_id integer,
	album_id integer
);

-- Создание дополнительной таблицы с информацией о Жанрах и Артистах
create table if not exists GenresArtists (
	genre_id integer,
	artist_id integer
);

-- Создание внешнего ключа ссылающегося на таблицу albums
alter table tracks
add foreign key (album_id) references albums (album_id);

-- Создание ключей для таблицы mixtapes
alter table mixtapes
add primary key (mixtape_id, track_id, album_id);

alter table mixtapes
add FOREIGN key(track_id) references tracks(track_id);

alter table mixtapes
add FOREIGN key(album_id) references albums(album_id);

-- Создание ключей для таблицы ArtistsAlbums
alter table artistsalbums
add primary key (artist_id, album_id);

alter table artistsalbums
add FOREIGN key(artist_id) references artists(artist_id);

alter table artistsalbums
add FOREIGN key(album_id) references albums(album_id);

-- Создание ключей для таблицы GenresArtists
alter table genresartists
add primary key (genre_id, artist_id);

alter table genresartists
add FOREIGN key(artist_id) references artists(artist_id);

alter table genresartists
add FOREIGN key(genre_id) references genres(genre_id);