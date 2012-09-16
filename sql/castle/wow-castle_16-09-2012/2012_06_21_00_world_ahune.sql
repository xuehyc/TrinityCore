-- set script names
UPDATE `creature_template` SET `ScriptName` = 'boss_ahune' WHERE `entry` = 25740;
UPDATE `creature_template` SET `ScriptName` = 'npc_frozen_core' WHERE `entry` = 25865;
UPDATE `creature_template` SET `ScriptName` = 'npc_ahunite_hailstone' WHERE `entry` = 25755;
UPDATE `creature_template` SET `ScriptName` = 'npc_ahunite_coldweave' WHERE `entry` = 25756;
UPDATE `creature_template` SET `ScriptName` = 'npc_ahunite_frostwind' WHERE `entry` = 25757;

-- update npc levels to wotlk, set factions to monster
UPDATE `creature_template` SET `minLevel` = 82, `maxLevel` = 82, `faction_A` = 14, `faction_H` = 14, `dmg_multiplier` = 2 WHERE `entry` = 26338;
UPDATE `creature_template` SET `minLevel` = 73, `maxLevel` = 73, `faction_A` = 14, `faction_H` = 14 WHERE `entry` = 25740;
UPDATE `creature_template` SET `minLevel` = 80, `maxLevel` = 80, `faction_A` = 14, `faction_H` = 14, `dmg_multiplier` = 2 WHERE `entry` IN (26339, 26342, 26340, 26341);
UPDATE `creature_template` SET `minLevel` = 70, `maxLevel` = 70, `faction_A` = 14, `faction_H` = 14 WHERE `entry` IN (25865, 25755, 25756, 25757);

-- update templates to make frozen core match ahune's health
UPDATE `creature_template` SET `exp` = 2, `Health_mod` = 39 WHERE `entry` IN (26338, 26339);
UPDATE `creature_template` SET `exp` = 2, `Health_mod` = 32 WHERE `entry` IN (25740, 25865);

-- update damage
-- ahune 
UPDATE `creature_template` SET 
    `mindmg` = 2200, 
    `maxdmg` = 2400, 
    `attackpower` = ROUND((`mindmg` + `maxdmg`) / 4 * 7), 
    `mindmg` = ROUND(`mindmg` - `attackpower` / 7), 
    `maxdmg` = ROUND(`maxdmg` - `attackpower` / 7) 
  WHERE `entry` IN (25740, 26338);
-- frostwind
-- coldweave
UPDATE `creature_template` SET
    `mindmg` = 350, 
    `maxdmg` = 450, 
    `attackpower` = ROUND((`mindmg` + `maxdmg`) / 4 * 7), 
    `mindmg` = ROUND(`mindmg` - `attackpower` / 7),
    `maxdmg` = ROUND(`maxdmg` - `attackpower` / 7) 
  WHERE `entry` IN (26341, 25757, 26340, 25756);
-- hailstone
UPDATE `creature_template` SET 
    `mindmg` = 650, 
    `maxdmg` = 800, 
    `attackpower` = ROUND((`mindmg` + `maxdmg`) / 4 * 7), 
    `mindmg` = ROUND(`mindmg` - `attackpower` / 7), 
    `maxdmg` = ROUND(`maxdmg` - `attackpower` / 7) 
  WHERE `entry` IN (26342, 25755);

-- spawn ice stone
DELETE FROM `gameobject` WHERE `id` = 187882 AND `map` = 547;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(440701, 187882, 547, 3, 1, -62.151, -160.632, -1.80114, 3.40964, 0, 0, 0.703812, 0.710386, 300, 0, 1);
DELETE FROM `game_event_gameobject` WHERE `guid` IN (440701,440795,440768,440770,440772,440774,440776,440778,440794);
INSERT INTO `game_event_gameobject` (`guid`, `evententry`) VALUES
(440701,1);

-- set ice stone summon script
UPDATE `gameobject_template` SET `ScriptName` = 'go_ice_stone' WHERE `entry` = 187882;

-- update quest relationship for "Summon Ahune!", remove quest end at luma, add one at icestone instead
DELETE FROM `creature_involvedrelation` WHERE `quest` = 11691;
DELETE FROM `gameobject_involvedrelation` WHERE `id` = 188152;
INSERT INTO `gameobject_involvedrelation` (`id`, `quest`) VALUES
(188152 , 11691);

-- implicit targeting for totem attack beam
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 46363;
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorTextId, ScriptName, Comment) VALUES
(13, 0, 46363, 0, 0, 18, 0, 1, 25740, 0, 0, 0, '', 'Beam Attack against Ahune 2 - targets Ahune');