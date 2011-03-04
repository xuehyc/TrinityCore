DELETE FROM `npc_vendor` WHERE `entry` IN (34060, 34078) AND `item` IN (42133, 42134, 42135, 42136, 42137);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`) VALUES
-- Battlemaster HORDE
(34060, 0, 42137, 0, 0, 2718),
(34060, 0, 42136, 0, 0, 2718),
(34060, 0, 42134, 0, 0, 2718),
(34060, 0, 42135, 0, 0, 2718),
(34060, 0, 42133, 0, 0, 2718),
-- Battlemaster ALLY
(34078, 0, 42137, 0, 0, 2718),
(34078, 0, 42136, 0, 0, 2718),
(34078, 0, 42134, 0, 0, 2718),
(34078, 0, 42135, 0, 0, 2718),
(34078, 0, 42133, 0, 0, 2718);
-- Relentless shields
DELETE FROM `npc_vendor` WHERE `entry` = 33927 AND `item` IN (42561, 42566, 42572);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`) VALUES
(33927, 0, 42561, 0, 0, 2701),
(33927, 0, 42567, 0, 0, 2701),
(33927, 0, 42572, 0, 0, 2701);
