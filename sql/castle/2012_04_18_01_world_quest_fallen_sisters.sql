-- @DorianGrey
-- Rework for npc behavior in  Q "The Fallen Sisters" (11314).
-- Up to now, the players had to attack Lurielle (quest giver, 24117) seven times, which was possible, but penetrating nerves.
-- The real targets, the Ice Nymphos (23678), could not be used due to a broken script-run (possibly based upon wrong evade behavior?).
-- Thus, I've rebuilt their behavior, i.e. modified id-orders and replaced the intended waypoint-movement at the end with a simple despawn.

-- Step 1: Update faction for Lurielle and the Frost Nymphos so they cannot be attacked (as intended).
UPDATE `creature_template` SET `faction_A`=35, `faction_H`=35 WHERE `entry` IN (23677, 24117);

-- Step 2: Drop former smart_scripts - entries for Ice Nympho.
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (23678, 2367800);

-- Step 3: Push the rebuilt ones.
INSERT INTO `smart_scripts` VALUES (23678, 0, 0, 0, 0, 0, 75, 0, 2000, 3000, 2000, 2000, 11, 9739, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Wrath on victim');
INSERT INTO `smart_scripts` VALUES (23678, 0, 1, 0, 2, 0, 100, 1, 0, 30, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Do text emote on health 30%');
INSERT INTO `smart_scripts` VALUES (23678, 0, 2, 3, 8, 0, 33, 0, 43340, 0, 0, 0, 33, 24117, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Spell hit 43340 - quest credit to player; with 33% chance');
INSERT INTO `smart_scripts` VALUES (23678, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'stop combat movement');
INSERT INTO `smart_scripts` VALUES (23678, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'set faction 35');
INSERT INTO `smart_scripts` VALUES (23678, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'despawn 5 secs after evasion');

-- Backup.
/*
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (23678, 2367800); 

INSERT INTO `smart_scripts` VALUES (2367800, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Say text 1');
INSERT INTO `smart_scripts` VALUES (2367800, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 53, 1, 23678, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'start waypoint movement');

INSERT INTO `smart_scripts` VALUES (23678, 0, 0, 0, 2, 0, 100, 1, 0, 30, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Do text emote on health 30%');
INSERT INTO `smart_scripts` VALUES (23678, 0, 1, 0, 0, 0, 75, 0, 2000, 3000, 2000, 2000, 11, 9739, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Wrath on victim');
INSERT INTO `smart_scripts` VALUES (23678, 0, 2, 3, 8, 0, 100, 0, 43340, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Spell hit 43340 face player');
INSERT INTO `smart_scripts` VALUES (23678, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'stop combat movement');
INSERT INTO `smart_scripts` VALUES (23678, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'evade');
INSERT INTO `smart_scripts` VALUES (23678, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'set faction 35');
INSERT INTO `smart_scripts` VALUES (23678, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 33, 24117, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'quest credit');
INSERT INTO `smart_scripts` VALUES (23678, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 2367800, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'load script');
INSERT INTO `smart_scripts` VALUES (23678, 0, 8, 0, 40, 0, 100, 0, 1, 23678, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On reach waypoint 1 despawn');
*/