create database virtualartgallery
use virtualartgallery

--ARTISTS TABLE
create table artists(
artistid int primary key,
name varchar(255) not null,
biography text,
nationality varchar(100))

drop table artists
drop table categories
drop table artworks
drop table exhibitions
drop table ExhibitionArtworks


-- CATEGORIES TABLE
create table categories(
categoryid int primary key,
name varchar(100) not null)


--ARTWORKS TABLE
create table artworks(
artworkid int primary key,
title varchar(255) not null,
artistid int,
categoryid int,
year int,
description text,
imageurl varchar(255),
constraint fk_aid foreign key(artistid) references artists(artistid),
constraint fk_cid foreign key(categoryid) references categories(categoryid))

--EXHIBITIONS TABLE

create table exhibitions(
exhibitionid int primary key,
title varchar(255),
startdate date,
enddate date,
description text)

--EXHIBITIONARTWORKS
create table exhibitionartworks(
exhibitionid int,
artworkid int,
primary key(exhibitionid, artworkid),
constraint fk_eid foreign key(exhibitionid)  references exhibitions(exhibitionid),
constraint fk_awid foreign key (artworkid) references artworks(artworkid))

insert into artists (artistid, name, biography, nationality)values 
(1, 'Pablo Picasso', 'Renowned Spanish painter and sculptor.', 'Spanish'),
(2, 'Vincent van Gogh', 'Dutch post-impressionist painter.', 'Dutch'),
(3, 'Leonardo da Vinci', 'Italian polymath of the Renaissance.', 'Italian');

insert into categories(categoryid, name) values 
(1, 'Painting'),
(2, 'Sculpture'),
(3, 'Photography');

insert into artworks(artworkid, title, artistid, categoryid, year, description, imageURL) values
(1, 'Starry Night', 2, 1, 1889, 'A famous painting by Vincent van Gogh.', 'starry_night.jpg'),
(2, 'Mona Lisa', 3, 1, 1503, 'The iconic portrait by Leonardo da Vinci.', 'mona_lisa.jpg'),
(3, 'Guernica', 1, 1, 1937, 'Pablo Picassos powerful anti-war mural.', 'guernica.jpg');

insert into exhibitions (exhibitionID, title, startDate, enddate, description) values
(1, 'Modern Art Masterpieces', '2023-01-01', '2023-03-01', 'A collection of modern art masterpieces.'),
(2, 'Renaissance Art', '2023-04-01', '2023-06-01', 'A showcase of Renaissance art treasures.');

insert into exhibitionartworks(exhibitionid,artworkid) values
(1, 1),
(1, 2),
(1, 3),
(2, 2);

--1
1.Retrieve the names of all artists along with the number of artworks they have in the gallery, and
list them in descending order of the number of artworks.
select a.name,count(aw.artworkid) as artworks
from artists a
left join artworks aw
on aw.artistid = a.artistid
group by a.name 
order by count(aw.artistid) desc


--2
2. List the titles of artworks created by artists from 'Spanish' and 'Dutch' nationalities, and order
them by the year in ascending order.
select aw.title,aw.year
from artworks aw
join artists a
on aw.artistid = a.artistid
where a.nationality in ('spanish', 'dutch')
order by aw.year asc


3. Find the names of all artists who have artworks in the 'Painting' category, and the number of
artworks they have in this category.
select a.name,count(aw.artistid) as a_count
from artists a
join artworks aw
on aw.artistid = a.artistid
join categories c
on c.categoryid = aw.categoryid
where c.name = 'painting'
group by a.name


--4
4. List the names of artworks from the 'Modern Art Masterpieces' exhibition, along with their
artists and categories.
select aw.title,a.name,c.name
from artworks aw
join artists a
on a.artistid = aw.artistid
join categories c
on c.categoryid = aw.categoryid
join exhibitionartworks ea
on ea.artworkid = aw.artworkid
join exhibitions e
on e.exhibitionid = ea.exhibitionid
where e.title = 'Modern Art Masterpieces'

5. Find the artists who have more than two artworks in the gallery.
select a.name,count(aw.artworkid) as aw_count
from artists a
join artworks aw
on aw.artistid = a.artistid
group by a.name
having count(aw.artistid) > 2

6. Find the titles of artworks that were exhibited in both 'Modern Art Masterpieces' and
'Renaissance Art' exhibitions
select aw.title
from artworks aw
join exhibitionartworks ea
on ea.artworkid = aw.artworkid
join exhibitions e
on ea.exhibitionid = e.exhibitionid
where e.title in ('Modern Art Masterpieces' ,
'Renaissance Art')
group by aw.title
having count(distinct e.title) = 2



7. Find the total number of artworks in each category
select c.name,count(aw.artworkid) as aw_count
from artworks aw
join categories c
on aw.categoryid = c.categoryid
group by c.name

8. List artists who have more than 3 artworks in the gallery.
select a.name,count(aw.artworkid) as aw_count
from artists a
join artworks aw
on aw.artistid = a.artistid
group by a.name
having count(aw.artworkid) > 3



9. Find the artworks created by artists from a specific nationality (e.g., Spanish).
select aw.title
from artworks aw
join artists a
on a.artistid = aw.artistid
where a.nationality =  'spanish'

10. List exhibitions that feature artwork by both Vincent van Gogh and Leonardo da Vinci.
select e.title
from exhibitions e
join exhibitionartworks ea
on ea.exhibitionid = e.exhibitionid
join artworks aw
on aw.artworkid = ea.artworkid
join artists a
on aw.artistid = a.artistid
where a.name in ('Vincent van Gogh' ,'Leonardo da Vinci')
group by e.title
having count(distinct a.name) = 2


11. Find all the artworks that have not been included in any exhibition.
select aw.title
from artworks aw
left join exhibitionartworks ea
on aw.artworkid = ea.artworkid
where ea.artworkid is null


12. List artists who have created artworks in all available categories.
select a.name
from artists a
join artworks aw
on a.artistid = aw.artistid
group by a.name
having count(distinct aw.categoryid) = (select count(*) from categories)


13. List the total number of artworks in each category.
select count(aw.artworkid)
from artworks aw
right join categories c
on c.categoryid = aw.categoryid
group by c.name

14. Find the artists who have more than 2 artworks in the gallery.
select a.name,count(aw.artworkid) as aw_count
from artists a
join artworks aw
on aw.artistid = a.artistid
group by a.name
having count(aw.artistid) > 2

15. List the categories with the average year of artworks they contain, only for categories with more
than 1 artwork.
select c.name,avg(aw.year) as avg_year
from categories c
join artworks aw 
on aw.categoryid = c.categoryid
group by c.name
having count(aw.artworkid) > 1

16. Find the artworks that were exhibited in the 'Modern Art Masterpieces' exhibition.
select aw.title
from artworks aw
join exhibitionartworks ea
on ea.artworkid = aw.artworkid
join exhibitions e
on e.exhibitionid = ea.exhibitionid
where e.title = 'Modern Art Masterpieces'


17. Find the categories where the average year of artworks is greater than the average year of all
artworks.
select c.name
from categories c
join artworks aw
on c.categoryid = aw.categoryid
group by c.name
having avg(aw.year) > (select avg(year) from artworks)

18. List the artworks that were not exhibited in any exhibition.
select aw.title
from artworks aw
left join exhibitionartworks ea
on aw.artworkid = ea.artworkid
where ea.artworkid is null

19. Show artists artists who have artworks in the same category as "Mona Lisa."
select a.name
from artists a
join artworks aw
on aw.artistid = a.artistid
where aw.categoryid = (select categoryid from artworks
where title = 'Mona Lisa')


20. List the names of artists and the number of artworks they have in the gallery.
select a.name,count(aw.artworkid) as aw_count
from artists a
join artworks aw
on aw.artistid = a.artistid
group by a.name

INSERT INTO artists (artistid, name, biography, nationality) VALUES
(4, 'Claude Monet', 'Founder of French Impressionist painting.', 'French'),
(5, 'Frida Kahlo', 'Mexican painter known for self-portraits.', 'Mexican');


insert into artworks (artworkid, title, artistid, categoryid, year, description, imageURL) values
(4, 'The Weeping Woman', 1, 2, 1937, 'Another powerful painting by Picasso.', 'weeping_woman.jpg'),
(5, 'Sunflowers', 2, 2, 1888, 'A series of still-life paintings by Van Gogh.', 'sunflowers.jpg'),
(6, 'The Last Supper', 3, 2, 1495, 'A mural painting by Leonardo da Vinci.', 'last_supper.jpg'),
(7, 'Self-Portrait', 1, 3, 1889, 'Vincent van Gogh’s self-portrait.', 'self_portrait.jpg'), 
(8, 'Warrior Statue', 2, 3, 1504, 'A powerful sculpture by Leonardo da Vinci.', 'warrior_statue.jpg');


insert into categories (categoryid, name) values
(4, 'Digital Art'),
(5, 'Surrealism');

delete from categories
where categoryid = 5


insert into artworks (artworkid, title, artistid, categoryid, year, description, imageURL) values
(9, 'Digital Dreams',3 , 3, 2021, 'A modern digital artwork by Picasso.', 'digital_dreams.jpg');
INSERT INTO artworks (artworkid, title, artistid, categoryid, year, description, imageURL) VALUES
(10, 'Picasso Artwork 1', 1, 3, 1935, 'Another Picasso painting.', 'picasso1.jpg'),
(11, 'Picasso Artwork 2', 2, 3, 1936, 'A Picasso sculpture.', 'picasso2.jpg'),
(12, 'Picasso Artwork 3', 3, 3, 1937, 'A Picasso photograph.', 'picasso3.jpg');


select* from categories


insert into exhibitionartworks (exhibitionid, artworkid) values
(2, 7),  
(2, 8);  

INSERT INTO artworks (artworkid, title, artistid, categoryid, year, description, imageURL) VALUES
(13, 'Sunset', 1, 3, 2020, 'A beautiful sunset painting.', 'sunset.jpg'),
(14, 'Stone Sculpture', 2, 3, 2021, 'A marble sculpture.', 'sculpture.jpg'),
(15, 'City Lights', 3, 3, 2022, 'A vibrant cityscape photograph.', 'city.jpg');

delete artworks
where artworkid = 15

