
-- http://www.wowhead.com/npc=33187		Sentinel Shyela
-- missing move

update creature_addon set path_id=7119700 where guid=71197;
update creature set MovementType=2 where guid=71197 and id=33187; -- GUID by ArkDB

delete from waypoint_data where id=7119700 and point in (1,2);
insert into waypoint_data values
(7119700,1,3812.46,147.85,8.53,0,2000,0,0,100,0),
(7119700,2,3847.47,143.71,7.19,0,2000,0,0,100,0);

