-- ********************* СОЗДАНИЕ ТАБЛИЦ *******************************
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

-- Создание дополнительной таблицы с информацией о Сборниках и Трэках
create table if not exists mixtapestracks (
	mixtape_id integer,
	track_id integer
);

-- ********************* КОНЕЦ СОЗДАНИЯ ТАБЛИЦ *******************************


-- ********************* ЗАПОЛНЕНИЕ ТАБЛИЦ *******************************
-- Заполнение таблицы с артистами
insert into artists values
    (1, 'Nine Inch Nails'),
    (2, 'Deftones'),
    (3, 'Alice In Chains'),
    (4, 'Converge'),
    (5, 'Kendrick Lamar'),
    (6, 'Death Grips'),
    (7, 'The Dillinger Escape Plan'),
    (8, 'TOOL');

-- Заполнение таблицы с альбомами
insert into albums values
    (1, 'The Downward Spiral', 1994),
    (2, 'White Pony', 2000),
    (3, 'Dirt', 1992),
    (4, 'Jane Doe', 2001),
    (5, 'To Pimp a Butterfly', 2015),
    (6, 'The Money Store', 2012),
    (7, 'Ire Works', 2007),
    (8, 'Lateralus', 2001),
    (9, 'Broken', 1992),
    (10, 'Around The Fur', 2018);

-- Заполнение таблицы с трэками
insert into tracks values
    (1, 1, 'Hurt', 307),
    (2, 1, 'Closer', 317),
    (3, 2, 'Knife Party', 435),
    (4, 2, 'Change(In The House of Flies)', 415),
    (5, 2, 'Digital Bath', 405),
    (6, 3, 'Would?', 406),
    (7, 3, 'Rooster', 416),
    (8, 4, 'Concubine', 135),
    (9, 5, 'u', 526),
    (10, 6, 'Get Got', 321),
    (11, 7, 'Milk Lizard', 221),
    (12, 8, 'Lateralus', 956),
    (13, 8, 'Schism', 756),
    (14, 8, 'The Grudge', 456),
    (15, 9, 'Wish', 234),
    (16, 10, 'My Own Summer (Shove it)', 334);

-- Заполнение таблицы с жанрами
insert into genres values
    (1, 'Mathcore'),
    (2, 'Progressive'),
    (3, 'Art Rock'),
    (4, 'Industrial'),
    (5, 'Hip-Hop'),
    (6, 'Noise Rap'),
    (7, 'Grunge'),
    (8, 'Metalcore'),
    (9, 'Noise');

-- Заполнение таблицы со сборниками
insert into mixtapes values
    (1, 'Mixtape1', 2018),
    (2, 'Mixtape2', 2019),
    (3, 'Mixtape3', 1996),
    (4, 'Mixtape4', 1995),
    (5, 'Mixtape5', 1999),
    (6, 'Mixtape6', 2011),
    (7, 'Mixtape7', 2020),
    (8, 'Mixtape8', 2005);

-- Заполнение таблицы связей Артист/Альбом
insert into artistsalbums values
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (1, 9),
    (2, 10);


-- Заполнение таблицы связей Жанр/Артист
insert into genresartists values
    (1, 4),
    (1, 7),
    (2, 8),
    (3, 2),
    (4, 1),
    (5, 5),
    (6, 6),
    (7, 3),
    (8, 4),
    (9, 1);


-- Заполнение таблицы связей Сборник/Трэк
insert into mixtapestracks values
    (1, 1),
    (2, 1),
    (1, 1),
    (3, 2),
    (5, 2),
    (4, 2),
    (6, 7),
    (7, 8),
    (8, 9);

-- ********************* КОНЕЦ ЗАПОЛНЕНИЯ ТАБЛИЦ *******************************


-- ********************* ОСНОВНОЕ ЗАДАНИЕ (SELECT QUERRIES) *******************************
--1. количество исполнителей в каждом жанре;
select gs.title, count(art.artist_name) as genre from genres gs
join genresartists ga
    on ga.genre_id = gs.genre_id
join artists art
    on art.artist_id = ga.artist_id 
group by gs.title;

--2. количество треков, вошедших в альбомы 2019-2020 годов;
select count(t.title) as tracks_cnt, a.release_year as album_released 
from tracks t
join albums a
    on t.album_id = a.album_id
group by a.release_year 
having a.release_year between 2018 and 2020;

--3. средняя продолжительность треков по каждому альбому;
select a.album_id, a.title as album_title, avg(t.duration) as avg_track_duration
from tracks t
join albums a
    on t.album_id = a.album_id
group by a.album_id order by a.album_id;

--4. все исполнители, которые не выпустили альбомы в 2020 году;
select a.artist_name from artists a
join artistsalbums aa
    on a.artist_id = aa.artist_id
join albums al
    on al.album_id = aa.album_id
where al.release_year != 2020;

--5. названия сборников, в которых присутствует конкретный исполнитель (выберите сами);
select distinct(m.title) as mixtape_title 
from mixtapes m
join mixtapestracks mt
	on m.mixtape_id = mt.mixtape_id
join tracks tr
	on tr.track_id = mt.track_id
join artistsalbums aa
	on aa.album_id = tr.album_id
join artists art
	on art.artist_id = aa.artist_id
where art.artist_name = 'Nine Inch Nails';

--6. название альбомов, в которых присутствуют исполнители более 1 жанра;
select a.title as album_title from albums a
join artistsalbums aa
    on aa.album_id = a.album_id
where aa.artist_id in 
    (
        select artist_id from genresartists group by artist_id having count(genre_id) > 1
);

--7. наименование треков, которые не входят в сборники;
select t.title from tracks t
left join mixtapestracks mt
    on mt.track_id = t.track_id
where mt.track_id is null;

--8. исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько);
select a.artist_name from artists a
join artistsalbums aa
on a.artist_id = aa.artist_id
where aa.album_id = (
	select album_id from albums where album_id = (
		select album_id from tracks where track_id = (
			select track_id from tracks where duration = (
				select min(duration) from tracks
				)
		)
	)
);

--9. название альбомов, содержащих наименьшее количество треков.
select title as album_title from albums
where album_id in (
	select album_id from tracks where album_id in (
		select album_id from tracks group by album_id having count(*) = (select min(mycnt) from (
			select album_id, count(album_id) as mycnt
			from tracks group by album_id
			) as min_cnt)
	)
);

