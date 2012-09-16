-- Wegweisende Visionen
UPDATE `quest_template` SET `SpecialFlags`=0 WHERE `Id`=10525; 
-- Die Donnerlanze
UPDATE `creature_template` SET `faction_A`=14,`faction_H`=14 WHERE `entry`=21319;
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (21319, 530, 1, 1, 0, 0, 1314.29, 6706.24, -19.2314, 5.24255, 300, 0, 0, 9489, 0, 0, 0, 0, 0);
