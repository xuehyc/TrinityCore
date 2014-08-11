
-- http://www.wowhead.com/npc=2788  Apprentice Kryten   The location of this NPC is unknown. This NPC is not in game. 
delete from creature where id=2788;

-- http://www.wowhead.com/npc=2789  Skuerto  he is spawned twice, one's on same place as http://www.wowhead.com/object=208120
delete from creature where guid=66547 and id=2789; -- GUID by ArkDB

-- http://www.wowhead.com/npc=2783 he walk 10 yards random on a small place..
update creature set spawndist=3 where guid=58355 and id=2783;  -- GUID by ArkDB

-- http://www.wowhead.com/npc=2597 he walk 10 yards random on a small place..
update creature set spawndist=3 where guid=70148 and id=2597;  -- GUID by ArkDB

-- http://www.wowhead.com/npc=2599 he walk 10 yards random on a small place..
update creature set spawndist=3 where guid=69310 and id=2599;  -- GUID by ArkDB

-- http://www.wowhead.com/quest=26051 disabled and autocomplete
UPDATE quest_template SET Method=2,Flags=0 WHERE Id=26051;
update gameobject_template set data8=26051 where entry=2712; -- missing quest entry
delete from gameobject_loot_template where entry=2712 and item=4492; -- missing loot
insert into gameobject_loot_template values (2712,4492,-100,1,0,1,1);


-- http://www.wowhead.com/quest=26628  Death From Below
UPDATE quest_template SET Flags=0 WHERE Id=26628; -- is unavaible

-- http://www.wowhead.com/npc=2596 has wrong level 39-40
UPDATE creature_template SET minlevel=27,maxlevel=27 WHERE entry=2596;

-- http://www.wowhead.com/quest=26429  Crush the Witherbark
UPDATE quest_template SET RequiredRaces=946 WHERE Id=26429; -- only horde
UPDATE creature_template SET KillCredit1=2555 WHERE entry=51633;

-- http://www.wowhead.com/quest=26035 Worth Its Weight in Gold
UPDATE quest_template SET RequiredRaces=1101 WHERE Id=26035; -- only ally

-- http://www.wowhead.com/npc=2554 2555 2556 no random move
update creature set spawndist=7, MovementType=1 where id in (2554,2555,2556);


-- http://www.wowhead.com/npc=2714  Forsaken Courier  missing movement
SET @Guid := 69760;  -- GUID By ArkDB
SET @WaypointID := @Guid * 10;

UPDATE creature SET MovementType=2 WHERE guid=@Guid; -- GUID By ArkDB
DELETE FROM creature_addon WHERE guid=@Guid;
INSERT INTO creature_addon VALUES(@Guid,@WaypointID,0,0,1,0,NULL);

DELETE FROM waypoint_data WHERE id=@WaypointID;
INSERT INTO waypoint_data VALUES (@WaypointID,1,-1644.145,-2971.353,26.5811,0,0,0,0,100,0);
INSERT INTO waypoint_data VALUES (@WaypointID,2,-1643.519,-2989.53,23.70307,0,0,0,0,100,0);
INSERT INTO waypoint_data VALUES (@WaypointID,3,-1637.653,-3006.231,20.70442,0,0,0,0,100,0);
INSERT INTO waypoint_data VALUES (@WaypointID,4,-1619.74,-3026.535,16.15639,0,0,0,0,100,0);
INSERT INTO waypoint_data VALUES (@WaypointID,5,-1604.707,-3041.557,15.10731,0,0,0,0,100,0);
INSERT INTO waypoint_data VALUES (@WaypointID,6,-1589.341,-3050.665,13.59976,0,0,0,0,100,0);
INSERT INTO waypoint_data VALUES (@WaypointID,7,-1577.276,-3044.095,13.51614,0,0,0,0,100,0);
INSERT INTO waypoint_data VALUES (@WaypointID,8,-1576.28,-3031.984,13.57204,0,0,0,0,100,0);
INSERT INTO waypoint_data VALUES (@WaypointID,9,-1569.835,-3026.596,12.6381,0,0,0,0,100,0);
INSERT INTO waypoint_data VALUES (@WaypointID,10,-1563.085,-3036.378,13.32643,0,0,0,0,100,0);
INSERT INTO waypoint_data VALUES (@WaypointID,11,-1568.097,-3043.396,13.66042,0,0,0,0,100,0);
INSERT INTO waypoint_data VALUES (@WaypointID,12,-1595.274,-3049.977,13.99394,0,0,0,0,100,0);
INSERT INTO waypoint_data VALUES (@WaypointID,13,-1620.803,-3024.375,16.42608,0,0,0,0,100,0);
INSERT INTO waypoint_data VALUES (@WaypointID,14,-1638.283,-3003.707,21.18772,0,0,0,0,100,0);
INSERT INTO waypoint_data VALUES (@WaypointID,15,-1647.745,-2983.672,25.06264,0,0,0,0,100,0);
INSERT INTO waypoint_data VALUES (@WaypointID,16,-1645.617,-2967.708,26.88402,0,0,0,0,100,0);
INSERT INTO waypoint_data VALUES (@WaypointID,17,-1640.653,-2954.119,28.00327,0,0,0,0,100,0);

-- http://www.wowhead.com/npc=2619  Hammerfall Grunt
-- http://www.wowhead.com/npc=2574  Drywhisker Digger
-- http://www.wowhead.com/npc=2573  Drywhisker Surveyor
-- http://www.wowhead.com/npc=2572  Drywhisker Kobold
-- http://www.wowhead.com/npc=2592  Rumbling Exile
update creature set spawndist=4, MovementType=1 where id in (2573,2574); -- no random move
update creature set spawndist=8, MovementType=1 where id in (2572,2619,2592);

-- http://www.wowhead.com/quest=26041  Stones of Binding
UPDATE quest_template SET Method=2,Flags=0 WHERE Id=26041; -- disabled

-- http://www.wowhead.com/npc=2602  Ruul Onestone  has wrong level 39# and is rare not elite..
UPDATE creature_template SET minlevel=29,maxlevel=29,npcflag=0,rank=4,dmg_multiplier=1.5,spell2=79886,spell3=82641,flags_extra=0 WHERE entry=2602;

-- http://www.wowhead.com/quest=26911 only horde
-- http://www.wowhead.com/quest=26346 only ally
UPDATE quest_template SET RequiredRaces=946 WHERE Id=26911; -- only horde
UPDATE quest_template SET RequiredRaces=1101 WHERE Id=26346; -- only ally

-- http://www.wowhead.com/quest=688 -- quest is obsolete.. has new id 26911 and 26346
delete from gameobject_queststarter where id=2688 and quest=653;
delete from gameobject_queststarter where id=2688 and quest=688;

-- http://www.wowhead.com/npc=2566 2567 no random move
update creature set spawndist=10, MovementType=1 where id in (2566,2567);

-- http://www.wowhead.com/npc=2604  Molok the Crusher  has wrong level
UPDATE creature_template SET minlevel=26,maxlevel=26 WHERE entry=2604;

-- http://www.wowhead.com/npc=2569 2570 no random move
update creature set spawndist=5, MovementType=1 where id in (2569,2570);





