-- Создание таблицы с информацией о исполнителях
create table if not exists artists (
	artist_id serial primary key,
	artist_name varchar(100) unique
);

-- Создание таблицы с информацией об альбомах
create table if not exists albums (
	album_id serial primary key,
	artist_id integer,
	album_name varchar(100),
	release_date integer
);

-- Создание таблицы с информацией о трэках
create table if not exists tracks (
	track_id serial primary key,
	album_id integer,
	track_name varchar(100),
	track_duration integer
);

-- Создание таблицы с информацией о жанрах
create table if not exists genres (
	genre_id serial primary key,
	artist_id int,
	genre_name varchar(100) unique
);

-- Создание внешнего ключа ссылающегося на таблицу albums
alter table tracks
add foreign key (album_id) references albums (album_id);

-- Создание внешнего ключа ссылающегося на таблицу artists
alter table albums
add foreign key (artist_id) references artists (artist_id);

-- Создание внешнего ключа ссылающегося на таблицу artists
alter table genres
add foreign key (artist_id) references artists (artist_id);