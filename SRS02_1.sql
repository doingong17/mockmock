create database [Film]
use [Film]

Create table Films
(
	ID int primary key not null,
	FilmDayOfWeek nvarchar(10),
	FilmDayOfYear nvarchar(10),
	FilmTime nvarchar(10),
	FilmId nvarchar(10)
);

Create table Name_Films
(
	FilmId nvarchar(10) primary key not null,
	FilmName nvarchar(20),
	Constructor nvarchar(10),
	Director nvarchar(10),
	DisplayTime nvarchar(10),
	FilmImage nvarchar(100),
	Trailer nvarchar(100),
	CharacterId nvarchar(10),
	LiberationTimeID nvarchar(10)
);

Create table Characters
(
	CharacterId nvarchar(10) primary key not null,
	CharacterName nvarchar(20)
);

Create table LiberationTime
(
	LiberationTimeId nvarchar(10) primary key not null,
	LiberationTimeName nvarchar(20)
);

INSERT INTO Films values (1, 'Monday', '2017/08/12', '12:00', 'NF1');
INSERT INTO Films values (2, 'Tuesday', '2017/08/13', '12:00', 'NF2');	
INSERT INTO Films values (3, 'Wednesday', '2017/08/13', '14:00', 'NF4');
INSERT INTO Films values (4, 'Monday', '2017/08/14', '12:00', 'NF3');
INSERT INTO Films values (5, 'Wednesday', '2017/08/14', '14:00', 'NF2');
INSERT INTO Films values (6, 'Sunday', '2017/08/15', '12:00', 'NF3');
INSERT INTO Films values (7, 'Monday', '2017/08/15', '14:00', 'NF1');
INSERT INTO Films values (8, 'Tuesday', '2017/08/15', '16:00', 'NF2');
INSERT INTO Films values (9, 'Monday', '2017/08/15', '16:00', 'NF1');

INSERT INTO Name_Films values ('NF1', 'Kacao', 'Nam', 'Tam', '7h', '1.jpg', '1.mp4', 'C1', 'L4');
INSERT INTO Name_Films values ('NF2', 'Kacao1', 'Nam', 'Tam', '8h', '2.jpg', '2.mp4', 'C4', 'L2');
INSERT INTO Name_Films values ('NF3', 'Kacao2', 'Nam', 'Tam', '8h', '2.jpg', '2.mp4', 'C2', 'L1');
INSERT INTO Name_Films values ('NF4', 'Kacao3', 'Nam', 'Tam', '8h', '2.jpg', '2.mp4', 'C3', 'L3');

INSERT INTO Characters values ('C1', 'LucVanTien');
INSERT INTO Characters values ('C2', 'MaVanTai'); 
INSERT INTO Characters values ('C3', 'ChungHoi'); 
INSERT INTO Characters values ('C4', 'BachMa'); 

INSERT INTO LiberationTime values ('L1', '2017/03/12');
INSERT INTO LiberationTime values ('L2', '2017/04/14');
INSERT INTO LiberationTime values ('L3', '2017/04/16');
INSERT INTO LiberationTime values ('L4', '2017/04/18');

select * from Films
select * from Name_Films
select * from Characters
select * from LiberationTime

SELECT n.FilmName, n.Constructor, n.Director, n.FilmImage,  c.CharacterName, l.LiberationTimeName, f.FilmDayOfYear, f.FilmTime  FROM Name_Films n INNER JOIN Films f ON f.FilmId = n.FilmId  INNER JOIN Characters c ON n.CharacterId = c.CharacterId  INNER JOIN LiberationTime l 
ON n.LiberationTimeId = l.LiberationTimeId  WHERE  l.LiberationTimeName = '2017/03/12' 

SELECT * FROM  ( SELECT n.FilmName, n.Constructor, n.Director, n.FilmImage, 
					 c.CharacterName, l.LiberationTimeName, f.FilmDayOfYear, f.FilmTime, 
					 ROW_NUMBER() over (ORDER BY ID ) as ct from  Name_Films n INNER JOIN Films f ON f.FilmId = n.FilmId  
					 INNER JOIN Characters c ON n.CharacterId = c.CharacterId 
					 INNER JOIN LiberationTime l ON n.LiberationTimeId = l.LiberationTimeId )  
					 sub WHERE LiberationTimeName = '2017/04/14' AND (ct >  1  AND ct <= 5 ) 
SELECT * FROM  ( SELECT n.FilmName, n.Constructor, n.Director, n.FilmImage,  c.CharacterName, l.LiberationTimeName, f.FilmDayOfYear, f.FilmTime,  
ROW_NUMBER() over (ORDER BY ID ) as ct from  Name_Films n INNER JOIN Films f ON f.FilmId = n.FilmId  INNER JOIN Characters c ON n.CharacterId = c.CharacterId  
INNER JOIN LiberationTime l ON n.LiberationTimeId = l.LiberationTimeId )   sub 
WHERE  LiberationTimeName = '2017/04/14' AND ( ct > 0 AND ct <= 4 )

select count(*) as num (SELECT * FROM  ( SELECT n.FilmName, n.Constructor, n.Director, n.FilmImage,  c.CharacterName, 
l.LiberationTimeName, f.FilmDayOfYear, f.FilmTime,  ROW_NUMBER() over (ORDER BY ID ) as ct from  Name_Films n INNER JOIN Films f 
ON f.FilmId = n.FilmId  INNER JOIN Characters c ON n.CharacterId = c.CharacterId  INNER JOIN LiberationTime l 
ON n.LiberationTimeId = l.LiberationTimeId )   sub 
WHERE  LiberationTimeName = '2017/04/14' AND ( ct > 0 AND ct <= 4 ))

select count(*) as num (SELECT * FROM  ( SELECT n.FilmName, n.Constructor, n.Director, n.FilmImage,  c.CharacterName, l.LiberationTimeName, f.FilmDayOfYear, f.FilmTime,  ROW_NUMBER() over (ORDER BY ID ) as ct from  Name_Films n INNER JOIN Films f ON f.FilmId = n.FilmId  INNER JOIN Characters c ON n.CharacterId = c.CharacterId  INNER JOIN LiberationTime l ON n.LiberationTimeId = l.LiberationTimeId )   sub 
WHERE  LiberationTimeName = '2017/03/12' AND ( ct > 0 AND ct <= 4 ))