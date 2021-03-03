DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 25 AND `SourceEntry` = 1190;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(25, 0, 1190, 0, 0, 27, 0, 90, 3, 0, 0, 0, 0, '', 'TerrainSwap 1190 only when player has level 90');
-- (25, 0, 1190, 0, 0, 47, 0, 34398, 8, 0, 0, 0, 0, '', 'Quest Warlords of Draenor: The Dark Portal');
