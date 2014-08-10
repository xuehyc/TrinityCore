


-- http://www.wowhead.com/npc=23051
-- move addon from creature to template.. same content.. so only to save some space on hdd

DELETE FROM `creature_addon` WHERE `guid` IN (SELECT guid FROM creature WHERE id=23051);

DELETE FROM `creature_template_addon` WHERE `entry`=23051;
INSERT INTO `creature_template_addon` (`entry`, `mount`, `bytes1`, `bytes2`, `auras`) VALUES
(23051, 0, 0x0, 0x1, '');
