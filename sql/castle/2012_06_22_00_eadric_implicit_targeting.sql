-- implicit target for hotr throwback in eadric the pure encounter
DELETE FROM conditions WHERE SourceTypeOrReferenceId = 13 AND SourceEntry = 66905;
INSERT INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorTextId, ScriptName, Comment) VALUES
(13, 0, 66905, 0, 0, 18, 0, 1, 35119, 0, 0, 0, '', 'Hammer of the Righteous - Implict Target Eadric the Pure');
