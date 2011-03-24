-- Fix Quest 4764 Doomrigger's Clasp

DELETE FROM `gameobject` WHERE `id` = 175382;
INSERT INTO `gameobject` (id, map, spawnMask, phaseMask, position_x, position_y, position_z, orientation, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state) VALUES (175382, 229, 1, 1, 67.128304, -297.420990, 91.425499, -0.034906, 0, 0, 0, 300, 0, 1);
DELETE FROM gameobject_questrelations WHERE quest = 4764;
INSERT INTO gameobject_questrelation (id, quest) VALUES (NULL, 4764);
DELETE FROM gameobject_involvedrelation WHERE quest = 4764;
INSERT INTO gameobject_involvedrelation (id, quest) VALUES (NULL, 4764);
DELETE FROM gameobject_loot_template WHERE entry = 175382;
INSERT INTO gameobject_loot_template (entry, item, ChanceOrQuestChance, groupid, mincountOrRef, maxcount, lootcondition, condition_value1, condition_value2) VALUES (175382, 12352, -100, 1, 1, 1, 9, 4764, 0);

