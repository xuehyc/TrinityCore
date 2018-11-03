-- fix - map changes in gilneas

DELETE FROM terrain_swap_defaults WHERE MapId = 654 AND TerrainSwapMap IN (655, 656);
INSERT INTO terrain_swap_defaults (MapId, TerrainSwapMap, Comment) VALUES
(654, 655, 'Gilneas duskhaven phase 1'),
(654, 656, 'Gilneas duskhaven phase 2');

DELETE FROM conditions WHERE SourceTypeOrReferenceId = 25 AND SourceEntry IN (655, 656);
INSERT INTO conditions (SourceTypeOrReferenceId, SourceEntry, ElseGroup, ConditionTypeOrReference, ConditionValue1, ConditionValue2, NegativeCondition) VALUES
(25, 638, 0, 47, 14396, 74, 1),
(25, 655, 0, 47, 14396, 74, 0),
(25, 655, 0, 47, 14467, 74, 1),
(25, 656, 0, 47, 14467, 74, 0);