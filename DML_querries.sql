-- Заполнение таблицы с артистами
insert into artists values(1, 'Nine Inch Nails');
insert into artists values(2, 'Deftones');
insert into artists values(3, 'Alice In Chains');
insert into artists values(4, 'Converge');
insert into artists values(5, 'Kendrick Lamar');
insert into artists values(6, 'Death Grips');
insert into artists values(7, 'The Dillinger Escape Plan');
insert into artists values(8, 'TOOL');

-- Заполнение таблицы с альбомами
insert into albums values(1, 'The Downward Spiral', 1994);
insert into albums values(2, 'White Pony', 2000);
insert into albums values(3, 'Dirt', 1992);
insert into albums values(4, 'Jane Doe', 2001);
insert into albums values(5, 'To Pimp a Butterfly', 2015);
insert into albums values(6, 'The Money Store', 2012);
insert into albums values(7, 'Ire Works', 2007);
insert into albums values(8, 'Lateralus', 2001);
insert into albums values(9, 'Broken', 1992);
insert into albums values(10, 'Around The Fur', 2018);

-- Заполнение таблицы с трэками
insert into tracks values(1, 1, 'Hurt', 307);
insert into tracks values(2, 1, 'Closer', 317);
insert into tracks values(3, 2, 'Knife Party', 435);
insert into tracks values(4, 2, 'Change(In The House of Flies)', 415);
insert into tracks values(5, 2, 'Digital Bath', 405);
insert into tracks values(6, 3, 'Would?', 406);
insert into tracks values(7, 3, 'Rooster', 416);
insert into tracks values(8, 4, 'Concubine', 135);
insert into tracks values(9, 5, 'u', 526);
insert into tracks values(10, 6, 'Get Got', 321);
insert into tracks values(11, 7, 'Milk Lizard', 221);
insert into tracks values(12, 8, 'Lateralus', 956);
insert into tracks values(13, 8, 'Schism', 756);
insert into tracks values(14, 8, 'The Grudge', 456);
insert into tracks values(15, 9, 'Wish', 234);
insert into tracks values(16, 10, 'My Own Summer (Shove it)', 334);

-- Заполнение таблицы с жанрами
insert into genres values(1, 'Mathcore');
insert into genres values(2, 'Progressive');
insert into genres values(3, 'Art Rock');
insert into genres values(4, 'Industrial');
insert into genres values(5, 'Hip-Hop');
insert into genres values(6, 'Noise Rap');
insert into genres values(7, 'Grunge');

-- Заполнение таблицы со сборниками
insert into mixtapes values(1, 1, 1, 'Mixtape1', 2020);
insert into mixtapes values(1, 2, 1, 'Mixtape1', 2018);
insert into mixtapes values(2, 1, 1, 'Mixtape2', 2019);
insert into mixtapes values(3, 3, 2, 'Mixtape3', 1996);
insert into mixtapes values(4, 5, 2, 'Mixtape4', 1995);
insert into mixtapes values(5, 4, 2, 'Mixtape5', 1999);
insert into mixtapes values(6, 11, 7, 'Mixtape6', 2011);
insert into mixtapes values(7, 13, 8, 'Mixtape7', 2020);
insert into mixtapes values(8, 15, 9, 'Mixtape8', 2005);

-- Заполнение таблицы связей Артист/Альбом
insert into artistsalbums values(1, 1);
insert into artistsalbums values(2, 2);
insert into artistsalbums values(3, 3);
insert into artistsalbums values(4, 4);
insert into artistsalbums values(5, 5);
insert into artistsalbums values(6, 6);
insert into artistsalbums values(7, 7);
insert into artistsalbums values(8, 8);
insert into artistsalbums values(1, 9);
insert into artistsalbums values(2, 10);


-- Заполнение таблицы связей Жанр/Артист
insert into genresartists values(1, 4);
insert into genresartists values(1, 7);
insert into genresartists values(2, 8);
insert into genresartists values(3, 2);
insert into genresartists values(4, 1);
insert into genresartists values(5, 5);
insert into genresartists values(6, 6);
insert into genresartists values(7, 3);

-- 1. название и год выхода альбомов, вышедших в 2018 году;
select title as album_title, release_year from albums where release_year = '2018';

-- 2. название и продолжительность самого длительного трека;
select title as track_title, duration from tracks where duration = (select max(duration) from tracks);

-- 3. название треков, продолжительность которых не менее 3,5 минуты;
select title as track_title from tracks where duration > 60 * 3.5;

-- 4. названия сборников, вышедших в период с 2018 по 2020 год включительно;
select title as mixtape_title from mixtapes where release_year between 2018 and 2020;

-- 5. исполнители, чье имя состоит из 1 слова;
select artist_name from artists 
where artist_name not like '% %' 
    and artist_name not like '%,%'
    and artist_name not like '%.%'
    and artist_name not like '%-%'
    and artist_name not like '%/%'
    and artist_name not like '%\%';

-- 6. название треков, которые содержат слово "мой"/"my"
select title as track_title from tracks where lower(title) like '%my%' or lower(title) like '%мой%';


-- ***************************************************************
-- DDL QUERIES
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