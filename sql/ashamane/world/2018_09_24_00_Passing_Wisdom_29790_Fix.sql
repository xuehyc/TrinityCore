-- Passing Wisdom Fix

-- Condition for phase 1885 Passing Wisdom

DELETE FROM conditions WHERE conditions.SourceTypeOrReferenceId = 26 AND conditions.SourceGroup IN (1885, 1527) AND conditions.ConditionValue1 = 29790;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
('26', '1885', '0', '0', '0', '9', '0', '29790', '0', '0', '0', '0', '0', '', 'Wandering Isle Phase 1885 when Quest 29790 taken'),
('26', '1885', '0', '0', '1', '28', '0', '29790', '0', '0', '0', '0', '0', '', 'Wandering Isle Phase 1885 when Quest 29790 complete'),
('26', '1885', '0', '0', '2', '8', '0', '29790', '0', '0', '0', '0', '0', '', 'Wandering Isle Phase 1885 when Quest 29790 rewarded');