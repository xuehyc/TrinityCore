-- Limit Rod of Compulsion to New Hearthglenn
DELETE FROM conditions WHERE SourceTypeOrReferenceId = 17 AND SourceEntry = 48712;
INSERT INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorTextId, ScriptName, Comment) VALUES 
(17, 0, 48712, 0, 0, 23, 0, 4180, 0, 0, 0, 0, '', 'Limit Rod of Compulsion to New Hearthglenn');