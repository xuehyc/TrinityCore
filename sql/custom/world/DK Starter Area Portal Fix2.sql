/*
https://www.wowhead.com/quest=13189/saurfangs-blessing
orgrimmar portal spells that work
originally spell 58418, however that does not work in game for the portal to orgrimmar spell portal in dk starter area
revert
*/
UPDATE `gameobject_template` SET `Data0`='58419' WHERE  `entry`=193052;

/*
https://www.wowhead.com/quest=13188/where-kings-walk
stormwind portal spell that work
originally spell 58420, however that does not work in game for the portal to stormwind spell portal in dk starter area
revert
*/
UPDATE `gameobject_template` SET `Data0`='58421' WHERE  `entry`=193053;

-- correct fix for orgrimmar
DELETE FROM `spell_target_position` WHERE  `ID`=58419;
INSERT INTO `spell_target_position` (`ID`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`) VALUES ('58419 ', '1', '1569.59', '-4397.63', '16.06', '0.54');

-- correct fix for stormwind portal
DELETE FROM `spell_target_position` WHERE  `ID`=58421;
INSERT INTO `spell_target_position` (`ID`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`) VALUES ('58421', '0', '-8833.37', '628.62', '94.00', '1.06');
