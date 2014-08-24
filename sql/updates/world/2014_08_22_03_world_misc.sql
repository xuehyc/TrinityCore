
-- all GUIDs for ArkDB
DELETE FROM `creature_addon` WHERE `guid` IN (224972,224971,216684,216830,216941,217936);
INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `bytes2`, `auras`) VALUES
(224972, 0, 0x10000, 0x101, '49415'), -- 26839 - 49415
(224971, 0, 0x10000, 0x101, '49415'), -- 26839 - 49415

(216684, 0, 0x10000, 0x1, '49414'), -- 26863 - 49414	 
(216830, 0, 0x10000, 0x101, '49414'), -- 26862 - 49414   
(216941, 0, 0x10000, 0x1, '49414'), -- 26860 - 49414	 
(217936, 0, 0x10000, 0x1, '49414'); -- 27102 - 49414	 

DELETE FROM `creature` WHERE `guid` in (217936,224972,224971);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `MovementType`) VALUES
(217936, 27102, 571, 1, 1, 3270.905, -2197.24, 117.4559, 4.101524, 120, 0, 0), -- 27102 (Area: 394)
(224972, 26839, 571, 1, 1, 3268.641, -2195.643, 117.4559, 4.34587, 120, 0, 0), -- 26839 (Area: 394)
(224971, 26839, 571, 1, 1, 3273.251, -2197.424, 117.4559, 4.066617, 120, 0, 0); -- 26839 (Area: 394)

DELETE FROM `spell_area` WHERE `spell` IN(49417,49416) AND `area`=4206;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`, `quest_start_status`, `quest_end_status`) VALUES 
(49417,4206, 12431, 0, 0, 0, 2, 1, 64, 11),
(49416,4206, 0, 12431, 0, 0, 2, 1, 64, 11);
