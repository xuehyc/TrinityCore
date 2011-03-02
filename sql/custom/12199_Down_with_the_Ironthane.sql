-- Iron Thane Furyhammer Flag
UPDATE `creature_template` SET `faction_A` = '14', `faction_H` = '14', `unit_class` = '1' WHERE entry = '26405';

-- Iron Thane Furyhammer Spawn
DELETE FROM `creature` WHERE id = '26405';
INSERT INTO `creature`(`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`,
`orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`,`curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`,`dynamicflags`)VALUES

( '26405', '571', '1', '1', '0', '1419', '3310.49', '-5103.89', '300.462', '4.30646', '300', '0', '0', '12762', '3561', '0', '0', '0', '0', '0');

