-- Fix herbalism
DELETE FROM `gameobject_template` WHERE `entry` IN (1617, 1618, 1619, 2866);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES 
(1617, 3, 270, 'Silverleaf', '', '', '', 0.6, 29, 1617, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 27602),
(1618, 3, 269, 'Peacebloom', '', '', '', 0.5, 29, 1618, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 27602),
(1619, 3, 414, 'Earthroot', '', '', '', 0.4, 29, 1619, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 27602),
(2866, 3, 2312, 'Firebloom', '', '', '', 1, 29, 2866, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 15595);

UPDATE gameobject_template_addon SET flags=0 WHERE `entry` IN (1618, 1617, 1619, 2866);

DELETE FROM `gameobject_loot_template` WHERE `Entry` IN (1617, 1618, 1619, 2866);
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES 
(1617, 765, 0, 100, 0, 1, 0, 1, 1, ''),
(1618, 2447, 0, 100, 0, 1, 0, 1, 1, ''),
(1619, 2449, 0, 100, 0, 1, 0, 1, 1, ''),
(2866, 4625, 0, 95, 0, 1, 0, 1, 1, ''),
(2866, 108332, 0, 5, 0, 1, 0, 1, 1, '');
