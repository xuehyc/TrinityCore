-- Update for quest: Scholomance (838)
UPDATE quest_template SET PrevQuestId = 0 WHERE entry = 27002;

/* Add script for creautre: Grom'thar the Thunderbringer (27002)
Script is needed to complete quest: Wanton Warlord (12151) */
UPDATE creature_loot_template SET ChanceOrQuestChance = -100 WHERE entry = 27002 AND item = 36853;
DELETE FROM event_scripts WHERE id = 17767;
INSERT INTO event_scripts VALUES (17767, 0, 10, 27002, 300000, 0, 2701.47, 430.836, 68.551, 6.158);

-- Aggro ignore for some creatures (24464, 24210, 24887, 24888, 24889, 27223)
UPDATE creature_template SET flags_extra = flags_extra|2 WHERE entry IN (24464, 24210, 24887, 24888, 24889, 27223);

-- Set Kabarg Windtamer (29757) to a fly master
UPDATE creature_template SET npcflag = npcflag|1|8192 WHERE entry = 29757;

-- Disable move for The Lich King (29110)
UPDATE creature_template SET unit_flags = unit_flags|4 WHERE entry = 29110;

/* IMPORTANT!
Tempfix (by Raccoon) for quest: News From the East (11501) */
UPDATE quest_template SET NextQuestID = 0 WHERE entry = 11494;
UPDATE quest_template SET NextQuestID = 0 WHERE entry = 11495;
UPDATE quest_template SET PrevQuestId = 11483 WHERE entry = 11501;

-- Add missing spell (Parry) to trainers - Thanks Nyi
DELETE FROM npc_trainer WHERE entry = 200002 AND spell = 3127;
INSERT INTO npc_trainer VALUES (200002,3127,100,0,0,6);

-- Update for item: Fire Seed (39969) and Fire Leaf (39970)
UPDATE item_template SET class = 7, subclass = 9 WHERE entry IN (39969,39970);

-- Add missing loot for: Technique: Rituals of the New Moon (46108)
DELETE FROM creature_loot_template WHERE item = 46108 AND entry IN (26679,26708,27546,27676);
INSERT INTO creature_loot_template VALUES
(26679, 46108, 2, 1, 0, 1, 1, 0, 0, 0),
(26708, 46108, 2, 1, 0, 1, 1, 0, 0, 0),
(27546, 46108, 0.3, 1, 0, 1, 1, 0, 0, 0),
(27676, 46108, 0.3, 1, 0, 1, 1, 0, 0, 0);

-- Add some loots to: Mature Lasher (34300)
DELETE FROM creature_loot_template WHERE item IN (37704,43324,44774,44775,44809) AND entry = 34300;
INSERT INTO creature_loot_template VALUES
(34300, 37704, 90, 1, 0, 1, 1, 0, 0, 0),
(34300, 43324, -14, 1, 0, 1, 1, 0, 0, 0),
(34300, 44774, 80, 1, 0, 1, 1, 0, 0, 0),
(34300, 44775, 19, 1, 0, 1, 1, 0, 0, 0),
(34300, 44809, -14, 1, 0, 1, 1, 0, 0, 0);

/* Add missing loots to some gameobjects
Loot is needed to complete quest: Lab Work (12557) */
UPDATE gameobject_template SET flags = 4, questItem1 = 38340 WHERE entry = 190459;
UPDATE gameobject_template SET flags = 4, questItem1 = 38340 WHERE entry = 190462;
UPDATE gameobject_template SET flags = 4, questItem1 = 38340 WHERE entry = 190473;
UPDATE gameobject_template SET flags = 4, questItem1 = 38340 WHERE entry = 190478;

UPDATE quest_template SET ReqItemId1 = 38386, ReqItemId2 = 38339, ReqItemId3 = 38340, ReqItemId4 = 38346, ReqItemCount1 = 1, ReqItemCount2 = 1, ReqItemCount3 = 1, ReqItemCount4 = 1, ReqCreatureOrGOId1 = 0, ReqCreatureOrGOId2 = 0, ReqCreatureOrGOId3 = 0, ReqCreatureOrGOId4 = 0, ReqCreatureOrGOCount1 = 0, ReqCreatureOrGOCount2 = 0, ReqCreatureOrGOCount3 = 0, ReqCreatureOrGOCount4 = 0 WHERE entry = 12557;