-- fix - 24930 while youre at it corect order if one of quests 14291, 14290, 14289, 14288, 14287, 14286, 14285 (all are safety in numbers) is rewarded

DELETE FROM `conditions` WHERE `SourceEntry`=24930 AND `ConditionValue1`=14291 AND `ElseGroup`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) 
VALUES (19, 0, 24930, 0, 0, 8, 0, 14291, 0, 0, 0, 0, 0, '', 'make quest 24930 while your at it available');
DELETE FROM `conditions` WHERE `SourceEntry`=24930 AND `ConditionValue1`=14290 AND `ElseGroup`=1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) 
VALUES (19, 0, 24930, 0, 1, 8, 0, 14290, 0, 0, 0, 0, 0, '', 'make quest 24930 while your at it available');
DELETE FROM `conditions` WHERE `SourceEntry`=24930 AND `ConditionValue1`=14289 AND `ElseGroup`=2;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) 
VALUES (19, 0, 24930, 0, 2, 8, 0, 14289, 0, 0, 0, 0, 0, '', 'make quest 24930 while your at it available');
DELETE FROM `conditions` WHERE `SourceEntry`=24930 AND `ConditionValue1`=14288 AND `ElseGroup`=3;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) 
VALUES (19, 0, 24930, 0, 3, 8, 0, 14288, 0, 0, 0, 0, 0, '', 'make quest 24930 while your at it available');
DELETE FROM `conditions` WHERE `SourceEntry`=24930 AND `ConditionValue1`=14287 AND `ElseGroup`=4;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) 
VALUES (19, 0, 24930, 0, 4, 8, 0, 14287, 0, 0, 0, 0, 0, '', 'make quest 24930 while your at it available');
DELETE FROM `conditions` WHERE `SourceEntry`=24930 AND `ConditionValue1`=14286 AND `ElseGroup`=5;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) 
VALUES (19, 0, 24930, 0, 5, 8, 0, 14286, 0, 0, 0, 0, 0, '', 'make quest 24930 while your at it available');
DELETE FROM `conditions` WHERE `SourceEntry`=24930 AND `ConditionValue1`=14285 AND `ElseGroup`=6;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) 
VALUES (19, 0, 24930, 0, 6, 8, 0, 14285, 0, 0, 0, 0, 0, '', 'make quest 24930 while your at it available');

-- fix - set previous quest 0 for quest 24930 while youre at it

DELETE FROM `quest_template_addon` WHERE `ID`=24930;
INSERT INTO `quest_template_addon` (`ID`, `MaxLevel`, `AllowableClasses`, `SourceSpellID`, `PrevQuestID`, `NextQuestID`, `ExclusiveGroup`, `RewardMailTemplateID`, `RewardMailDelay`, `RequiredSkillID`, `RequiredSkillPoints`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepValue`, `ProvidedItemCount`, `SpecialFlags`, `ScriptName`) 
VALUES (24930, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');


