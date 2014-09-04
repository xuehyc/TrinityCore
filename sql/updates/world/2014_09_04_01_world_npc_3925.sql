
-- http://www.wowhead.com/npc=3925	Thistlefur Avenger
-- the area is without moving.. i add some few..

update creature set MovementType=2 where guid=71087; -- GUID by ArkDB
update creature_addon set path_id=7108700 where guid=71087; -- GUID by ArkDB

delete from waypoint_data where id=7108700;
insert into waypoint_data values 
(7108700,1,2895.74,-103.54,100.096,0,2000,0,0,100,0),
(7108700,2,2944.83,-98.65,97.0,0,2000,0,0,100,0);

update creature set MovementType=2 where guid=98006; -- GUID by ArkDB
delete from creature_addon where guid=98006;
insert into creature_addon values
(98006,9800600,0,0,0,0,"");

delete from waypoint_data where id=9800600;
insert into waypoint_data values 
(9800600,1,2917.69,-119.15,99.47,0,2000,0,0,100,0),
(9800600,2,2912.73,-127.44,104.65,0,0,0,0,100,0),
(9800600,3,2907.48,-130.66,106.513,0,2000,0,0,100,0);


update creature set MovementType=2 where guid=70753; -- GUID by ArkDB
delete from creature_addon where guid=70753;
insert into creature_addon values
(70753,7075300,0,0,0,0,"");

delete from waypoint_data where id=7075300;
insert into waypoint_data values 
(7075300,1,3122.36,-190.62,106.87,0,2000,0,0,100,0),
(7075300,2,3064.79,-160.86,101.523,0,2000,0,0,100,0);

update creature set MovementType=2 where guid=71888; -- GUID by ArkDB
delete from creature_addon where guid=71888;
insert into creature_addon values
(71888,7188800,0,0,0,0,"");

delete from waypoint_data where id=7188800;
insert into waypoint_data values 
(7188800,1,3181.40,-221.67,114.98,0,2000,0,0,100,0),
(7188800,2,3187.68,-230.79,116.40,0,0,0,0,100,0),
(7188800,3,3254.73,-245.69,121.45,0,2000,0,0,100,0),
(7188800,4,3187.68,-230.79,116.40,0,0,0,0,100,0);


-- some random move on different npc
update creature set spawndist=5,MovementType=1 where guid in (80186,97980,97982,97986,72455,99236,97985,71139);
update creature set spawndist=10,MovementType=1 where guid in (70953,98001,97994,72212,97967,72784,99233,99263,98002,70327,97972);

update creature set spawndist=5,MovementType=1 where id in (3823,3819);


