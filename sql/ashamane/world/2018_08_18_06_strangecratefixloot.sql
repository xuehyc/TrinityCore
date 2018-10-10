DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=5 AND `SourceGroup`=139777;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(5, 139777, 139776, 0, 0, 6, 0, 67, 0, 0, 0, 0, '', "Only receive item when you are Horde"),
(5, 139777, 139775, 0, 0, 6, 0, 469, 0, 0, 0, 0, '', "Only receive item when you are Alliance");

DELETE FROM `item_loot_template` WHERE `entry`='139777';
INSERT INTO `item_loot_template` (`entry`, `item`, `Chance`, `lootmode`, `groupid`, `mincount`, `maxcount`) VALUES
( 139777,  139776,  100, 1 ,  0,  1,  1),
( 139777,  139775,  100, 1 ,  0,  1,  1);