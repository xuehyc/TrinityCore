
-- crater un'goro

-- wrong position
UPDATE creature SET position_x=-7831.897,position_y=-2120.488,position_z=-255.4627 WHERE guid=74142;

-- append pool, mother pool=14549
SET @MP=14549;
update pool_template set max_limit=41 where entry=@MP;
-- append beginning from next free pool_template 14651
SET @PP=14651;
delete from pool_template where entry between @PP and @PP+4;
insert into pool_template values (@PP+0,1,"group36, Ravasaurus, crater un'goro");
insert into pool_template values (@PP+1,1,"group37, Ravasaurus, crater un'goro");
insert into pool_template values (@PP+2,1,"group38, Ravasaurus, crater un'goro");
insert into pool_template values (@PP+3,1,"group39, Ravasaurus, crater un'goro");
insert into pool_template values (@PP+4,1,"group40, Ravasaurus, crater un'goro");

delete from pool_pool where pool_id between @PP and @PP+4;
insert into pool_pool values (@PP+0,@MP,0,"group36, Ravasaurus, crater un'goro");
insert into pool_pool values (@PP+1,@MP,0,"group37, Ravasaurus, crater un'goro");
insert into pool_pool values (@PP+2,@MP,0,"group38, Ravasaurus, crater un'goro");
insert into pool_pool values (@PP+3,@MP,0,"group39, Ravasaurus, crater un'goro");
insert into pool_pool values (@PP+4,@MP,0,"group40, Ravasaurus, crater un'goro");

delete from pool_creature where pool_entry between @PP and @PP+4;
insert into pool_creature values (73731,@PP,0,"group36, Ravasaurus, crater un'goro");
insert into pool_creature values (113556,@PP,0,"group36, Ravasaurus, crater un'goro");
insert into pool_creature values (113647,@PP+1,0,"group37, Ravasaurus, crater un'goro");
insert into pool_creature values (105441,@PP+1,0,"group37, Ravasaurus, crater un'goro");
insert into pool_creature values (113734,@PP+1,0,"group37, Ravasaurus, crater un'goro");
insert into pool_creature values (73761,@PP+1,0,"group37, Ravasaurus, crater un'goro");
insert into pool_creature values (113643,@PP+2,0,"group38, Ravasaurus, crater un'goro");
insert into pool_creature values (73705,@PP+2,0,"group38, Ravasaurus, crater un'goro");
insert into pool_creature values (105877,@PP+3,0,"group39, Ravasaurus, crater un'goro");
insert into pool_creature values (73711,@PP+3,0,"group39, Ravasaurus, crater un'goro");
insert into pool_creature values (73741,@PP+3,0,"group39, Ravasaurus, crater un'goro");
insert into pool_creature values (73780,@PP+4,0,"group40, Ravasaurus, crater un'goro");
insert into pool_creature values (105424,@PP+4,0,"group40, Ravasaurus, crater un'goro");
insert into pool_creature values (105549,@PP+4,0,"group40, Ravasaurus, crater un'goro");

-- double wrong queststarter
delete from creature_queststarter where id=38263 and quest=24689;

-- wrong faction
update creature_template set faction_A=2263,faction_H=2263 where entry=9119;

-- quest 24702
DELETE FROM gameobject_queststarter WHERE quest = 24702;
INSERT INTO gameobject_queststarter VALUES (202135, 24702);
DELETE FROM gameobject_questender WHERE quest = 24702;
INSERT INTO gameobject_questender VALUES (202135, 24702);
UPDATE quest_template SET Flags=8 WHERE Id=24702;

-- quest 4501
UPDATE quest_template SET Flags=8 WHERE Id=4501;

-- game object 157936  missing loot
update gameobject_template set data1=157936 where entry=157936;
DELETE FROM gameobject_loot_template WHERE entry=157936 AND item=11018;
INSERT INTO gameobject_loot_template VALUES (157936, 11018, 100, 1, 0, 1, 4);

-- game object 201979 not bound to quest and missing loot
update gameobject_template set data8=24715 where entry=201979;
DELETE FROM gameobject_loot_template WHERE entry=201979 AND item=50237;
INSERT INTO gameobject_loot_template VALUES (201979, 50237, -100, 1, 0, 1, 1);

-- one gorilla is under water
UPDATE creature SET position_x=-6400.585,position_y=-1779.197,position_z=-269.9635 WHERE guid=73990;

-- append pool for gorilla 6513,6514, mother pool=14656
SET @MP=14656;
delete from pool_template where entry =@MP;
insert into pool_template values (@MP,16,"Motherpool, gorilla, crater un'goro");
-- append beginning from next free pool_template 14657
SET @PP=14657;
delete from pool_template where entry between @PP and @PP+14;
insert into pool_template values (@PP+0,1,"group1, gorilla, crater un'goro");
insert into pool_template values (@PP+1,1,"group2, gorilla, crater un'goro");
insert into pool_template values (@PP+2,1,"group3, gorilla, crater un'goro");
insert into pool_template values (@PP+3,1,"group4, gorilla, crater un'goro");
insert into pool_template values (@PP+4,1,"group5, gorilla, crater un'goro");
insert into pool_template values (@PP+5,1,"group6, gorilla, crater un'goro");
insert into pool_template values (@PP+6,1,"group7, gorilla, crater un'goro");
insert into pool_template values (@PP+7,1,"group8, gorilla, crater un'goro");
insert into pool_template values (@PP+8,1,"group9, gorilla, crater un'goro");
insert into pool_template values (@PP+9,1,"group10, gorilla, crater un'goro");
insert into pool_template values (@PP+10,1,"group11, gorilla, crater un'goro");
insert into pool_template values (@PP+11,1,"group12, gorilla, crater un'goro");
insert into pool_template values (@PP+12,1,"group13, gorilla, crater un'goro");
insert into pool_template values (@PP+13,1,"group14, gorilla, crater un'goro");
insert into pool_template values (@PP+14,1,"group15, gorilla, crater un'goro");

delete from pool_pool where pool_id between @PP and @PP+14;
insert into pool_pool values (@PP+0,@MP,0,"group1, gorilla, crater un'goro");
insert into pool_pool values (@PP+1,@MP,0,"group2, gorilla, crater un'goro");
insert into pool_pool values (@PP+2,@MP,0,"group3, gorilla, crater un'goro");
insert into pool_pool values (@PP+3,@MP,0,"group4, gorilla, crater un'goro");
insert into pool_pool values (@PP+4,@MP,0,"group5, gorilla, crater un'goro");
insert into pool_pool values (@PP+5,@MP,0,"group6, gorilla, crater un'goro");
insert into pool_pool values (@PP+6,@MP,0,"group7, gorilla, crater un'goro");
insert into pool_pool values (@PP+7,@MP,0,"group8, gorilla, crater un'goro");
insert into pool_pool values (@PP+8,@MP,0,"group9, gorilla, crater un'goro");
insert into pool_pool values (@PP+9,@MP,0,"group10, gorilla, crater un'goro");
insert into pool_pool values (@PP+10,@MP,0,"group11, gorilla, crater un'goro");
insert into pool_pool values (@PP+11,@MP,0,"group12, gorilla, crater un'goro");
insert into pool_pool values (@PP+12,@MP,0,"group13, gorilla, crater un'goro");
insert into pool_pool values (@PP+13,@MP,0,"group14, gorilla, crater un'goro");
insert into pool_pool values (@PP+14,@MP,0,"group15, gorilla, crater un'goro");

delete from pool_creature where pool_entry between @PP and @PP+14;
insert into pool_creature values (113771,@PP+0,0,"group1, gorilla, crater un'goro");
insert into pool_creature values (73992,@PP+0,0,"group1, gorilla, crater un'goro");
insert into pool_creature values (73991,@PP+1,0,"group2, gorilla, crater un'goro");
insert into pool_creature values (105960,@PP+1,0,"group2, gorilla, crater un'goro");
insert into pool_creature values (73990,@PP+1,0,"group2, gorilla, crater un'goro");
insert into pool_creature values (74002,@PP+2,0,"group3, gorilla, crater un'goro");
insert into pool_creature values (105779,@PP+2,0,"group3, gorilla, crater un'goro");
insert into pool_creature values (74010,@PP+3,0,"group4, gorilla, crater un'goro");
insert into pool_creature values (105759,@PP+3,0,"group4, gorilla, crater un'goro");
insert into pool_creature values (74011,@PP+4,0,"group5, gorilla, crater un'goro");
insert into pool_creature values (74003,@PP+4,0,"group5, gorilla, crater un'goro");
insert into pool_creature values (105979,@PP+5,0,"group6, gorilla, crater un'goro");
insert into pool_creature values (74004,@PP+5,0,"group6, gorilla, crater un'goro");
insert into pool_creature values (73989,@PP+6,0,"group7, gorilla, crater un'goro");
insert into pool_creature values (105368,@PP+6,0,"group7, gorilla, crater un'goro");
insert into pool_creature values (105817,@PP+7,0,"group8, gorilla, crater un'goro");
insert into pool_creature values (73995,@PP+7,0,"group8, gorilla, crater un'goro");
insert into pool_creature values (74013,@PP+8,0,"group9, gorilla, crater un'goro");
insert into pool_creature values (105826,@PP+8,0,"group9, gorilla, crater un'goro");
insert into pool_creature values (74008,@PP+9,0,"group10, gorilla, crater un'goro");
insert into pool_creature values (105502,@PP+9,0,"group10, gorilla, crater un'goro");
insert into pool_creature values (74000,@PP+10,0,"group11, gorilla, crater un'goro");
insert into pool_creature values (113894,@PP+10,0,"group11, gorilla, crater un'goro");
insert into pool_creature values (73988,@PP+11,0,"group12, gorilla, crater un'goro");
insert into pool_creature values (105820,@PP+11,0,"group12, gorilla, crater un'goro");
insert into pool_creature values (73997,@PP+12,0,"group13, gorilla, crater un'goro");
insert into pool_creature values (74007,@PP+12,0,"group13, gorilla, crater un'goro");
insert into pool_creature values (74005,@PP+13,0,"group14, gorilla, crater un'goro");
insert into pool_creature values (73996,@PP+13,0,"group14, gorilla, crater un'goro");
insert into pool_creature values (74143,@PP+14,0,"group15, gorilla, crater un'goro");
insert into pool_creature values (113688,@PP+14,0,"group15, gorilla, crater un'goro");

-- update max_limit for some mother pool templates
update pool_template set max_limit=29 where entry=14498;
update pool_template set max_limit=42 where entry=14518;
update pool_template set max_limit=23 where entry=14619;
update pool_template set max_limit=27 where entry=14632;

-- append pool Tar Lord
SET @MP=14585;
update pool_template set max_limit=45 where entry=@MP;
SET @PP=14672;
delete from pool_template where entry between @PP and @PP+5;
insert into pool_template values (@PP+0,1,"group35, Tar Lord, crater un'goro");
insert into pool_template values (@PP+1,1,"group36, Tar Lord, crater un'goro");
insert into pool_template values (@PP+2,1,"group37, Tar Lord, crater un'goro");
insert into pool_template values (@PP+3,1,"group38, Tar Lord, crater un'goro");
insert into pool_template values (@PP+4,1,"group39, Tar Lord, crater un'goro");
insert into pool_template values (@PP+5,1,"group40, Tar Lord, crater un'goro");

delete from pool_pool where pool_id between @PP and @PP+5;
insert into pool_pool values (@PP+0,@MP,0,"group35, Tar Lord, crater un'goro");
insert into pool_pool values (@PP+1,@MP,0,"group36, Tar Lord, crater un'goro");
insert into pool_pool values (@PP+2,@MP,0,"group37, Tar Lord, crater un'goro");
insert into pool_pool values (@PP+3,@MP,0,"group38, Tar Lord, crater un'goro");
insert into pool_pool values (@PP+4,@MP,0,"group39, Tar Lord, crater un'goro");
insert into pool_pool values (@PP+5,@MP,0,"group40, Tar Lord, crater un'goro");

delete from pool_creature where pool_entry between @PP and @PP+5;
insert into pool_creature values (113879,@PP+0,0,"group35, Tar Lord, crater un'goro");
insert into pool_creature values (74125,@PP+0,0,"group35, Tar Lord, crater un'goro");
insert into pool_creature values (113765,@PP+1,0,"group36, Tar Lord, crater un'goro");
insert into pool_creature values (74123,@PP+1,0,"group36, Tar Lord, crater un'goro");
insert into pool_creature values (113527,@PP+2,0,"group37, Tar Lord, crater un'goro");
insert into pool_creature values (74120,@PP+2,0,"group37, Tar Lord, crater un'goro");
insert into pool_creature values (106066,@PP+3,0,"group38, Tar Lord, crater un'goro");
insert into pool_creature values (74129,@PP+3,0,"group38, Tar Lord, crater un'goro");
insert into pool_creature values (105619,@PP+4,0,"group39, Tar Lord, crater un'goro");
insert into pool_creature values (74022,@PP+4,0,"group39, Tar Lord, crater un'goro");
insert into pool_creature values (105865,@PP+5,0,"group40, Tar Lord, crater un'goro");
insert into pool_creature values (74021,@PP+5,0,"group40, Tar Lord, crater un'goro");

-- npc wrong position
UPDATE creature SET position_x=-6854.324,position_y=-1263.877,position_z=-272.3425 WHERE guid=105636;
UPDATE creature SET position_x=-6542.809,position_y=-1267.885,position_z=-271.8371 WHERE guid=74048;
UPDATE creature SET position_x=-6554.769,position_y=-1213.911,position_z=-269.1637 WHERE guid=74046;

